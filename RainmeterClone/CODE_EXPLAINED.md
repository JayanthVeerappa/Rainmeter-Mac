# CODE WALKTHROUGH - What Each Part Does

This document explains the code in plain English.

---

## 🎯 RainmeterCloneApp.swift - The Starting Point

```swift
@main
struct RainmeterCloneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
```

**What it does:**
- `@main` tells macOS "this is where the app starts"
- `@NSApplicationDelegateAdaptor` connects to our AppDelegate (the old-school way of managing apps)
- `Settings` scene is required but we make it empty since we don't need a settings window
- This is the modern SwiftUI way of starting an app

**Why we need it:**
- Every SwiftUI app needs an entry point with `@main`
- We use AppDelegate because we need low-level control over the window

---

## 🎮 AppDelegate.swift - The Controller

```swift
class AppDelegate: NSObject, NSApplicationDelegate {
    var widgetWindow: DesktopWidgetWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from Dock and Cmd+Tab
        NSApp.setActivationPolicy(.accessory)
        
        // Load custom font
        FontLoader.loadCustomFont()
        
        // Create and show the widget window
        widgetWindow = DesktopWidgetWindow()
        widgetWindow?.makeKeyAndOrderFront(nil)
        widgetWindow?.orderFrontRegardless()
    }
```

**What it does:**
1. When app launches, `applicationDidFinishLaunching` runs
2. `.accessory` policy = invisible in Dock and Cmd+Tab (like background utility)
3. Loads your custom font from the bundle
4. Creates the widget window
5. Shows it on screen (`makeKeyAndOrderFront` + `orderFrontRegardless` = "show NOW!")

**Why we need it:**
- To hide the app from Dock/Cmd+Tab
- To load fonts before the UI appears
- To create and manage our custom window

---

## 🪟 DesktopWidgetWindow.swift - The Magic Window

### Part 1: Create Special Window

```swift
super.init(
    contentRect: initialRect,
    styleMask: [.borderless, .nonactivatingPanel],
    backing: .buffered,
    defer: false
)
```

**What it does:**
- `contentRect`: Size and position (400x250 pixels)
- `.borderless`: No title bar, no close button
- `.nonactivatingPanel`: Clicking it doesn't make it the "active" window
- `.buffered`: Use memory buffer for smooth rendering

### Part 2: Desktop-Level Positioning

```swift
self.level = .init(Int(CGWindowLevelForKey(.desktopWindow)) + 1)
```

**What it does:**
- Gets the "desktop level" (where your wallpaper is)
- Adds 1 to put it just above the wallpaper
- Result: Above wallpaper, below all other windows

### Part 3: Transparency

```swift
self.backgroundColor = .clear
self.isOpaque = false
self.hasShadow = false
```

**What it does:**
- `.clear` = completely transparent background
- `isOpaque = false` = tells macOS "this window has transparency"
- `hasShadow = false` = no window shadow

### Part 4: Special Behaviors

```swift
self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
```

**What it does:**
- `.canJoinAllSpaces`: Visible on all virtual desktops
- `.stationary`: Doesn't move when switching spaces
- `.ignoresCycle`: Not part of Cmd+` window cycling

### Part 5: Make It Draggable

```swift
self.isMovableByWindowBackground = true
```

**What it does:**
- Clicking anywhere on the widget and dragging moves the whole window

### Part 6: Save Position

```swift
@objc func windowDidMove(_ notification: Notification) {
    WindowPositionManager.savePosition(self.frame.origin)
}
```

**What it does:**
- Every time you drag the window, this function runs
- Saves the new position to UserDefaults
- Next launch, window appears at same spot

---

## 🎨 WidgetContentView.swift - The Visual Design

### Part 1: The Layout

```swift
VStack(spacing: 8) {
    // Day of week - Big
    Text(timeManager.dayOfWeek)
        .font(.custom("AnuratiPro-Regular", size: 64))
    
    // Date - Smaller
    Text(timeManager.date)
        .font(.custom("AnuratiPro-Regular", size: 28))
    
    // Time - Slightly smaller
    Text(timeManager.time)
        .font(.custom("AnuratiPro-Regular", size: 36))
}
```

**What it does:**
- `VStack` = vertical stack (items arranged top to bottom)
- `spacing: 8` = 8 points of space between items
- Three `Text` views with different font sizes
- Custom font "AnuratiPro-Regular" loaded from your font file

### Part 2: Styling

```swift
.foregroundColor(.white)
.shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
```

**What it does:**
- White text color
- Subtle black shadow (30% opacity, 2pt blur, offset 1pt right and 1pt down)
- Makes text readable on any wallpaper

### Part 3: Dragging

```swift
.gesture(
    DragGesture()
        .onChanged { value in
            let newOrigin = NSPoint(
                x: window.frame.origin.x + value.translation.width,
                y: window.frame.origin.y - value.translation.height
            )
            window.setFrameOrigin(newOrigin)
        }
        .onEnded { _ in
            WindowPositionManager.savePosition(window.frame.origin)
        }
)
```

**What it does:**
- Detects when you click and drag
- `onChanged`: While dragging, calculate new position based on how far you dragged
- `onEnded`: When you release, save the final position
- Note: `y` is inverted because macOS coordinates are flipped (0,0 is bottom-left)

---

## ⏰ TimeManager - The Clock

```swift
class TimeManager: ObservableObject {
    @Published var dayOfWeek: String = ""
    @Published var date: String = ""
    @Published var time: String = ""
    
    private var timer: Timer?
```

**What it does:**
- `ObservableObject` = SwiftUI can watch this for changes
- `@Published` = when these change, SwiftUI automatically updates the UI
- `timer` = updates time every second

### Updating Time

```swift
timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
    self?.updateTime()
}
```

**What it does:**
- Creates a timer that fires every 1.0 seconds
- `repeats: true` = keep firing forever
- `[weak self]` = don't create memory leak (allows timer to release when done)
- Calls `updateTime()` every second

### Formatting

```swift
let dayFormatter = DateFormatter()
dayFormatter.dateFormat = "EEEE"
dayOfWeek = dayFormatter.string(from: now).uppercased()
```

**What it does:**
- `EEEE` = full day name (Monday, Tuesday, etc.)
- `.uppercased()` = MONDAY, TUESDAY, etc.

```swift
dateFormatter.dateFormat = "MMMM d, yyyy"
```
- `MMMM` = full month (December)
- `d` = day number without leading zero (1, 2, 3... 31)
- `yyyy` = four-digit year (2025)
- Result: "December 1, 2025"

```swift
timeFormatter.dateFormat = "HH:mm:ss"
```
- `HH` = 24-hour format with leading zero (00-23)
- `mm` = minutes with leading zero (00-59)
- `ss` = seconds with leading zero (00-59)
- Result: "14:30:45"

---

## 💾 WindowPositionManager - Remember Position

### Saving

```swift
static func savePosition(_ origin: NSPoint) {
    let positionDict: [String: CGFloat] = ["x": origin.x, "y": origin.y]
    UserDefaults.standard.set(positionDict, forKey: positionKey)
}
```

**What it does:**
- Takes window origin (x, y coordinates)
- Creates a dictionary: `{x: 150.0, y: 300.0}`
- Saves to UserDefaults (like a small database built into macOS)
- Key is "widgetWindowPosition"

### Loading

```swift
static func loadPosition() -> NSPoint {
    if let positionDict = UserDefaults.standard.dictionary(forKey: positionKey) as? [String: CGFloat],
       let x = positionDict["x"],
       let y = positionDict["y"] {
        return NSPoint(x: x, y: y)
    }
```

**What it does:**
- Looks up "widgetWindowPosition" in UserDefaults
- If found, extracts x and y values
- Returns as NSPoint
- If not found (first launch), calculates default position (center of screen)

---

## 🔤 FontLoader - Load Custom Font

```swift
static func loadCustomFont() {
    let fontNames = ["AnuratiPro-Regular"]
    
    for fontName in fontNames {
        for ext in ["ttf", "otf"] {
            if let fontURL = Bundle.main.url(forResource: fontName, withExtension: ext, subdirectory: "Fonts") {
                registerFont(from: fontURL)
            }
        }
    }
}
```

**What it does:**
1. List of font file names (without extension)
2. Loop through each font name
3. Try to find it with .ttf extension, then .otf
4. Look in "Fonts" subdirectory of app bundle
5. If found, register it with macOS

### Registering

```swift
private static func registerFont(from url: URL) {
    var errorRef: Unmanaged<CFError>?
    guard CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef) else {
        print("Failed to register font: \(url.lastPathComponent)")
        return
    }
    print("Successfully registered font: \(url.lastPathComponent)")
}
```

**What it does:**
- `CTFontManagerRegisterFontsForURL` = CoreText function to load font
- `.process` = available for this process only (not system-wide)
- If successful, font can be used with `.custom("AnuratiPro-Regular", size: XX)`
- If fails, prints error to console

---

## 📄 Info.plist - Configuration

### Key Settings

```xml
<key>LSUIElement</key>
<true/>
```
**What it does:** Hides app from Dock and Cmd+Tab switcher

```xml
<key>ATSApplicationFontsPath</key>
<string>Fonts/</string>
```
**What it does:** Tells macOS where to find font files in the app bundle

```xml
<key>UIAppFonts</key>
<array>
    <string>Fonts/AnuratiPro-Regular.otf</string>
</array>
```
**What it does:** Lists font files to load automatically

```xml
<key>LSMinimumSystemVersion</key>
<string>13.0</string>
```
**What it does:** Requires macOS Ventura (13.0) or newer

---

## 🔄 App Lifecycle - What Happens When

### Launch Sequence:

1. **macOS starts app** → finds `@main` in RainmeterCloneApp.swift
2. **SwiftUI initializes** → creates AppDelegate via @NSApplicationDelegateAdaptor
3. **AppDelegate launches** → `applicationDidFinishLaunching()` runs
4. **Hide from Dock** → `setActivationPolicy(.accessory)`
5. **Load font** → `FontLoader.loadCustomFont()` registers Anurati Pro
6. **Get saved position** → `WindowPositionManager.loadPosition()`
7. **Create window** → `DesktopWidgetWindow()` initialized at saved position
8. **Create UI** → `WidgetContentView` created with TimeManager
9. **Start timer** → TimeManager starts 1-second repeating timer
10. **Show window** → `makeKeyAndOrderFront()` displays widget
11. **Update loop** → Timer fires every second, updating time display

### Runtime Loop:

```
Every 1 second:
  └─> Timer fires
      └─> updateTime() called
          └─> Get current Date()
          └─> Format day/date/time strings
          └─> Update @Published properties
              └─> SwiftUI detects change
                  └─> Re-render text views with new values
```

### Dragging:

```
User clicks and drags:
  └─> DragGesture detects movement
      └─> Calculate new position
      └─> Move window to new position
      └─> NSWindow.didMoveNotification fires
          └─> windowDidMove() called
              └─> WindowPositionManager.savePosition()
                  └─> Save to UserDefaults
```

### Quit:

```
User quits app (Cmd+Q or Activity Monitor):
  └─> Timer invalidated
  └─> Window closed
  └─> App terminates
  └─> Position already saved in UserDefaults
```

---

## 🧠 Memory Management

**Lightweight design:**
- One window (NSPanel)
- One SwiftUI view tree
- One timer (1 Hz)
- Three string properties updated per second
- Two CGFloat values in UserDefaults

**Why it's efficient:**
- No background processes
- No network activity
- No file I/O after launch
- Timer only does string formatting (cheap operation)
- SwiftUI only re-renders changed views (smart diffing)

**Expected footprint:** < 50 MB RAM

---

## 🎛️ How Everything Connects

```
App Launch
    ↓
RainmeterCloneApp (@main)
    ↓
AppDelegate.applicationDidFinishLaunching()
    ↓
    ├─> FontLoader.loadCustomFont() → Registers font
    ├─> WindowPositionManager.loadPosition() → Gets saved position
    └─> DesktopWidgetWindow() → Creates window
            ↓
            └─> WidgetContentView → SwiftUI UI
                    ↓
                    └─> TimeManager → Clock logic
                            ↓
                            └─> Timer (1 second) → Updates display
```

**Data Flow:**
```
Timer fires
    ↓
TimeManager.updateTime()
    ↓
DateFormatter creates strings
    ↓
@Published properties updated
    ↓
SwiftUI detects changes
    ↓
Text views re-render with new values
    ↓
Display updates on screen
```

**Position Persistence:**
```
User drags window
    ↓
DragGesture updates window.frame.origin
    ↓
NSNotification.didMove fires
    ↓
windowDidMove() called
    ↓
WindowPositionManager.savePosition()
    ↓
UserDefaults stores {x, y}
    ↓
Next launch: loadPosition() retrieves {x, y}
    ↓
Window appears at same spot
```

---

## 🚀 Performance Optimizations

1. **Timer precision:** 1 second (not milliseconds) - no need for higher frequency
2. **SwiftUI diffing:** Only re-renders changed text, not entire view tree
3. **UserDefaults:** Only writes on position change, not every frame
4. **Font loading:** Once at launch, cached by system
5. **No animations:** Instant updates, no GPU overhead
6. **Transparent window:** Composited by window server, minimal CPU

---

**This is how all the pieces work together to create a lightweight, efficient desktop widget!**

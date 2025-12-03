# PROJECT FOLDER STRUCTURE

```
RainmeterClone/
│
├── RainmeterCloneApp.swift          # ✓ Main app entry point with @main
│   └── Uses @NSApplicationDelegateAdaptor for AppDelegate
│
├── AppDelegate.swift                 # ✓ Application lifecycle management
│   ├── Hides app from Dock (NSApplication.setActivationPolicy(.accessory))
│   ├── Loads custom font on launch
│   └── Creates and manages the widget window
│
├── DesktopWidgetWindow.swift        # ✓ Custom NSPanel subclass
│   ├── Borderless, transparent window
│   ├── Desktop-level positioning (above wallpaper, below windows)
│   ├── Position persistence via NotificationCenter
│   ├── Draggable with isMovableByWindowBackground
│   └── Non-activating panel configuration
│
├── WidgetContentView.swift          # ✓ SwiftUI view + TimeManager
│   ├── Day/Date/Time display with custom font
│   ├── TimeManager class: updates every second via Timer
│   ├── Drag gesture for window repositioning
│   └── White text with subtle shadow effects
│
├── WindowPositionManager.swift      # ✓ UserDefaults persistence
│   ├── savePosition() - stores x,y coordinates
│   └── loadPosition() - retrieves saved position or calculates default
│
├── FontLoader.swift                 # ✓ Custom font registration
│   ├── Loads fonts from Resources/Fonts/ folder
│   └── Uses CTFontManagerRegisterFontsForURL
│
├── Info.plist                       # ✓ App configuration
│   ├── LSUIElement: YES (hides from Dock & Cmd+Tab)
│   ├── ATSApplicationFontsPath: Fonts/
│   ├── UIAppFonts array with font file name
│   └── Minimum macOS version: 13.0 (Ventura)
│
├── README.md                        # ✓ Project documentation
│
├── XCODE_SETUP_GUIDE.md            # ✓ Complete step-by-step Xcode instructions
│
└── Resources/
    └── Fonts/
        └── AnuratiPro-Regular.otf   # ⚠️ YOU MUST ADD YOUR FONT FILE HERE
            (or .ttf - whatever your font file extension is)
```

---

## FILE DESCRIPTIONS

### Core Application Files

**RainmeterCloneApp.swift**
- Entry point with @main attribute
- Uses SwiftUI App lifecycle
- Integrates AppDelegate via @NSApplicationDelegateAdaptor
- Minimal Settings scene (required but empty)

**AppDelegate.swift**
- NSApplicationDelegate implementation
- Sets activation policy to .accessory (hides from Dock/Cmd+Tab)
- Loads custom font on app launch
- Creates and retains the widget window
- Prevents app termination when window closes

**DesktopWidgetWindow.swift**
- Custom NSPanel subclass for the widget
- Borderless, transparent configuration
- Window level set to desktop layer + 1
- Stays on all spaces (.canJoinAllSpaces)
- Ignores window cycling (.ignoresCycle)
- Movable by window background
- Observes position changes for persistence
- Hosts SwiftUI content via NSHostingView

**WidgetContentView.swift**
- SwiftUI view displaying day/date/time
- TimeManager ObservableObject updates every second
- Custom font rendering with shadow effects
- DragGesture for window repositioning
- Automatic text sizing and formatting

**WindowPositionManager.swift**
- Static utility for position persistence
- Uses UserDefaults to store/retrieve window origin
- Calculates smart default position (center-ish of screen)
- Dictionary-based storage for x,y coordinates

**FontLoader.swift**
- Registers custom fonts with CoreText
- Searches for fonts in bundle resources
- Supports both .ttf and .otf formats
- Error handling with console logging

---

## CONFIGURATION FILES

**Info.plist**
Essential keys:
- `LSUIElement`: true - Hides app from Dock and Cmd+Tab
- `ATSApplicationFontsPath`: "Fonts/" - Font directory
- `UIAppFonts`: Array with font filenames
- `LSMinimumSystemVersion`: 13.0 - macOS Ventura minimum
- `NSSupportsAutomaticGraphicsSwitching`: true - GPU optimization

---

## KEY FEATURES EXPLAINED

### Desktop Layer Positioning
Window level is set to `CGWindowLevelForKey(.desktopWindow) + 1`
- Above wallpaper
- Below all other windows
- Doesn't interfere with normal window management

### Click-Through vs Draggable
- Base behavior: ignoresMouseEvents = false (can interact)
- Drag gesture in SwiftUI handles movement
- Window moves with mouse during drag
- Position automatically saved on move

### No Dock Icon / No Cmd+Tab
- `NSApp.setActivationPolicy(.accessory)` in AppDelegate
- `LSUIElement = true` in Info.plist
- Both are required for complete invisibility

### Position Persistence
- UserDefaults stores {x: CGFloat, y: CGFloat} dictionary
- Saved whenever window moves (NSWindow.didMoveNotification)
- Loaded on app launch before window creation
- Smart default if no saved position exists

### Font Loading
- Fonts must be in Resources/Fonts/ folder
- Must be added to Xcode target
- Must be listed in Info.plist UIAppFonts array
- Loaded via CTFontManagerRegisterFontsForURL before window creation

### Timer-Based Updates
- Timer.scheduledTimer updates TimeManager every 1 second
- DateFormatter creates formatted strings
- @Published properties trigger SwiftUI view updates
- Automatic, efficient rendering

---

## DEPENDENCIES

- **macOS Ventura (13.0)** or later
- **SwiftUI** - Modern UI framework
- **AppKit** - Native macOS window management (NSPanel, NSWindow)
- **CoreText** - Font loading (CTFontManagerRegisterFontsForURL)
- **Foundation** - UserDefaults, Date, DateFormatter, Timer

---

## BUILDING THE PROJECT

### From Xcode (Development):
1. Open Xcode
2. File → Open → Select RainmeterClone folder
3. Cmd+B to build
4. Cmd+R to run

### Standalone App (Distribution):
1. Product → Archive
2. Distribute App → Copy App
3. Export to desired location

### Quick Test Build:
1. Product → Build For → Running
2. Products folder → Right-click RainmeterClone.app → Show in Finder
3. Copy .app anywhere and double-click

---

## WHAT EACH FILE DOES AT RUNTIME

1. **Launch**: RainmeterCloneApp.swift (@main) starts
2. **Delegate**: AppDelegate.applicationDidFinishLaunching() called
3. **Hide**: setActivationPolicy(.accessory) hides from Dock
4. **Font**: FontLoader.loadCustomFont() registers Anurati Pro
5. **Window**: DesktopWidgetWindow() created with saved/default position
6. **Content**: WidgetContentView loaded into window via NSHostingView
7. **Timer**: TimeManager starts 1-second repeating timer
8. **Display**: Widget appears on desktop
9. **Updates**: Time/date/day update every second automatically
10. **Drag**: User can drag widget, position saved to UserDefaults
11. **Persist**: Next launch loads saved position

---

## MEMORY FOOTPRINT

Extremely lightweight:
- Single NSPanel window
- One SwiftUI view
- One Timer (1 Hz update rate)
- Minimal UserDefaults storage (2 CGFloat values)
- No background processes
- No network activity
- No file I/O after launch

Expected RAM usage: < 50 MB

---

## CUSTOMIZATION POINTS

### Visual:
- Font sizes in WidgetContentView.swift (.font size parameters)
- Colors in WidgetContentView.swift (.foregroundColor)
- Shadow in WidgetContentView.swift (.shadow parameters)
- Window size in DesktopWidgetWindow.swift (initialRect dimensions)

### Behavior:
- Update frequency in TimeManager (timer interval)
- Date/time formats in TimeManager (DateFormatter.dateFormat)
- Window level in DesktopWidgetWindow.swift (window level calculation)
- Default position in WindowPositionManager.swift

### Advanced:
- Add more text fields to WidgetContentView
- Add background blur or color
- Add animations to time changes
- Add system info (CPU, RAM, weather, etc.)
- Support multiple widgets

---

## TROUBLESHOOTING REFERENCE

| Problem | Solution |
|---------|----------|
| Font not loading | Check font file name matches exactly in Info.plist |
| Widget off-screen | Delete UserDefaults: `defaults delete com.yourname.RainmeterClone` |
| Appears in Dock | Verify LSUIElement = true in Info.plist |
| Can't drag | Check isMovableByWindowBackground = true |
| Wrong window layer | Verify window.level calculation |
| Build errors | Clean build folder (Shift+Cmd+K) then rebuild |
| Font file not found | Check Target Membership is checked for font |

---

END OF STRUCTURE DOCUMENT

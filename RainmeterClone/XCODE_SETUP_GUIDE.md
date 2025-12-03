# COMPLETE XCODE SETUP GUIDE FOR RAINMETER CLONE

This guide assumes **ZERO Xcode experience**. Follow every step exactly.

---

## STEP 1: CREATE NEW XCODE PROJECT

1. **Open Xcode** (from Applications folder or Spotlight)
2. You'll see a welcome window. Click **"Create New Project"**
   - If you don't see this, go to menu: **File → New → Project...**
3. In the template chooser:
   - At the top, select **"macOS"** tab (NOT iOS)
   - Click on **"App"** template
   - Click **"Next"** button at bottom right
4. Fill in the project details:
   - **Product Name:** `RainmeterClone`
   - **Team:** Select your team (or leave as "None")
   - **Organization Identifier:** `com.yourname` (e.g., `com.jayanth`)
   - **Bundle Identifier:** Will auto-fill as `com.yourname.RainmeterClone`
   - **Interface:** Select **"SwiftUI"**
   - **Language:** Select **"Swift"**
   - **UNCHECK** "Use Core Data"
   - **UNCHECK** "Include Tests" (both checkboxes)
   - Click **"Next"**
5. Choose save location:
   - Navigate to `/Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/`
   - Click **"Create"**

**✓ You now have a blank Xcode project open**

---

## STEP 2: DELETE DEFAULT FILES

Xcode created some default files we don't need.

1. In the left sidebar (Navigator), you'll see a folder icon called **"RainmeterClone"**
2. Click the small triangle next to it to expand it
3. You'll see these files:
   - `RainmeterCloneApp.swift`
   - `ContentView.swift`
   - `Assets.xcassets`
   - Maybe others
4. **RIGHT-CLICK** on `ContentView.swift`
5. Select **"Delete"**
6. In the popup, click **"Move to Trash"** (NOT "Remove Reference")

**✓ Default ContentView removed**

---

## STEP 3: ADD ALL THE SWIFT FILES

Now we'll add the code files I created for you.

### Method: Drag and Drop

1. Open Finder
2. Navigate to `/Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/RainmeterClone/`
3. You should see these files:
   - `RainmeterCloneApp.swift`
   - `AppDelegate.swift`
   - `DesktopWidgetWindow.swift`
   - `WidgetContentView.swift`
   - `WindowPositionManager.swift`
   - `FontLoader.swift`
   - `Info.plist`
4. **Select ALL these files** (Cmd+A or click first, then Shift+click last)
5. **DRAG them** from Finder into the Xcode left sidebar
6. Drop them onto the **"RainmeterClone"** folder (the blue folder icon)
7. A dialog appears with options:
   - **CHECK** "Copy items if needed"
   - **CHECK** "Create groups" (should be selected)
   - **CHECK** that "RainmeterClone" target is checked
   - Click **"Finish"**

**✓ All Swift files are now in your project**

---

## STEP 4: ADD YOUR CUSTOM FONT

1. In Finder, locate your **Anurati Pro** font file
   - It should be named something like `AnuratiPro-Regular.otf` or `.ttf`
2. **COPY** this font file to:
   `/Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/RainmeterClone/Resources/Fonts/`
   - If you don't have the font yet, download it and place it here
   - Make sure it's named exactly: `AnuratiPro-Regular.otf` (or `.ttf`)
3. In Xcode, in the left sidebar:
   - **RIGHT-CLICK** on the "RainmeterClone" folder
   - Select **"Add Files to RainmeterClone..."**
4. In the file picker:
   - Navigate to the `Resources/Fonts/` folder
   - Select your `AnuratiPro-Regular.otf` file
   - **CHECK** "Copy items if needed"
   - **CHECK** "Create groups"
   - **CHECK** the "RainmeterClone" target
   - Click **"Add"**

**✓ Font is now in your project**

---

## STEP 5: CONFIGURE INFO.PLIST

The Info.plist I provided has all the settings, but let's make sure Xcode uses it.

1. In the left sidebar, click on the **"RainmeterClone"** file (very top, blue icon)
   - This is the project settings
2. In the main editor area, you'll see tabs. Make sure **"RainmeterClone"** under TARGETS is selected (not PROJECTS)
3. Click the **"Info"** tab (top of the editor area)
4. You'll see various settings. Scroll down to find:
   - **"Application requires iPhone environment"** - If you see this, you're looking at wrong target (should be macOS)
5. Look for **"Custom macOS Application Target Properties"** or similar
6. Find or add these entries (click + button to add):
   - `LSUIElement` → Boolean → `YES` (this hides from Dock)
   - `ATSApplicationFontsPath` → String → `Fonts/`
7. To add custom fonts array:
   - Click + button
   - Type: `UIAppFonts` (or select "Fonts provided by application")
   - Make it an Array
   - Click the triangle next to it to expand
   - Click + to add an item
   - Set value: `Fonts/AnuratiPro-Regular.otf`

**ALTERNATIVE:** If the above is confusing:

1. In left sidebar, find `Info.plist` file
2. **RIGHT-CLICK** on it
3. Select **"Open As → Source Code"**
4. **DELETE** all contents
5. **PASTE** the entire contents of the Info.plist file I provided
6. Press **Cmd+S** to save
7. **RIGHT-CLICK** again → **"Open As → Property List"** to go back to normal view

**✓ Info.plist is configured**

---

## STEP 6: VERIFY FONT IN TARGET MEMBERSHIP

1. In left sidebar, click on your font file `AnuratiPro-Regular.otf`
2. On the RIGHT side of Xcode (right sidebar), find **"Target Membership"**
   - If you don't see the right sidebar, click the icon at top right (looks like a document)
3. **CHECK** the box next to "RainmeterClone"

**✓ Font is included in app bundle**

---

## STEP 7: SET MINIMUM macOS VERSION

1. Click on the **"RainmeterClone"** project (blue icon) in left sidebar
2. Under TARGETS, select **"RainmeterClone"**
3. Click **"General"** tab
4. Find **"Minimum Deployments"**
5. Set **"macOS"** to **13.0** (Ventura) or higher

**✓ Deployment target set**

---

## STEP 8: CONFIGURE SIGNING (IF NEEDED)

1. Still in the **"General"** tab
2. Scroll to **"Signing & Capabilities"** section
3. If you see an error about signing:
   - Check **"Automatically manage signing"**
   - Select your **Team** from dropdown (your Apple ID)
   - Xcode will automatically create a signing certificate
4. If you don't have a team:
   - You can still build and run locally
   - Just ignore any signing warnings for now

**✓ Signing configured (or skipped for local testing)**

---

## STEP 9: BUILD THE PROJECT

1. At the top of Xcode, find the scheme selector (shows "RainmeterClone > My Mac")
   - If it says "Any Mac", that's fine too
2. Press **Cmd+B** to build
   - Or go to menu: **Product → Build**
3. Wait for build to complete (watch bottom bar for progress)
4. If you see errors:
   - Read the error message carefully
   - Common issues:
     - Font file not found: Check step 4 again
     - Signing issues: Check step 8
     - Syntax errors: Make sure all files copied correctly

**✓ Project builds successfully**

---

## STEP 10: RUN THE APP

1. Press **Cmd+R** to run
   - Or click the **Play** button (▶) at top left
   - Or go to menu: **Product → Run**
2. The app will launch
3. **YOU WON'T SEE IT IN THE DOCK!** (This is intentional)
4. Look at your desktop - you should see the widget appear showing:
   - Day of week (big)
   - Date (medium)
   - Time (medium-small)
5. **Test dragging:**
   - Click and hold on the widget
   - Drag it anywhere on screen
   - Release
6. **Test persistence:**
   - Press **Cmd+Q** to quit the app (or right-click Xcode icon in Dock → Quit)
   - Press **Cmd+R** again to run
   - Widget should appear at the same position

**✓ App is running!**

---

## STEP 11: BUILD STANDALONE .APP

To create an app you can double-click without Xcode:

1. In Xcode menu: **Product → Archive**
2. Wait for archive to complete
3. The Organizer window opens automatically
4. Click **"Distribute App"**
5. Select **"Copy App"**
6. Click **"Next"**
7. Choose a save location (e.g., Desktop)
8. Click **"Export"**
9. You'll have a **RainmeterClone.app** file
10. **Double-click it** to run
11. If macOS says "can't be opened":
    - **RIGHT-CLICK** on the app
    - Hold **Option** key
    - Click **"Open"**
    - Click **"Open"** in the warning dialog
    - This only needs to be done once

**ALTERNATIVE (Simpler for local use):**

1. In Xcode menu: **Product → Build For → Running**
2. In left sidebar, expand **"Products"** folder at the bottom
3. **RIGHT-CLICK** on `RainmeterClone.app`
4. Select **"Show in Finder"**
5. **COPY** this .app file to anywhere you want
6. Double-click to run

**✓ You have a standalone .app file!**

---

## TROUBLESHOOTING

### Font doesn't load / Text appears in system font
1. Check that font file is named exactly `AnuratiPro-Regular.otf`
2. Verify font file is in `Resources/Fonts/` folder
3. Check Info.plist has correct font path
4. Make sure Target Membership is checked for the font
5. Clean build: **Product → Clean Build Folder** (Shift+Cmd+K)
6. Rebuild: **Product → Build** (Cmd+B)

### Widget doesn't appear
1. Check Console (bottom of Xcode) for error messages
2. Widget might be off-screen - try resetting position by deleting UserDefaults:
   - In Terminal: `defaults delete com.yourname.RainmeterClone`
3. Make sure LSUIElement is set to true in Info.plist

### App appears in Dock
- Info.plist is not configured correctly
- Make sure `LSUIElement` is set to `YES` (Boolean true)

### Widget is not draggable
- Check that window has `isMovableByWindowBackground = true`
- Make sure the contentShape modifier is present in SwiftUI view

### Widget doesn't stay on desktop layer
- Check window level setting in DesktopWidgetWindow.swift
- Verify collectionBehavior includes `.stationary`

---

## DONE!

You now have a fully functional Rainmeter-style desktop widget for macOS!

**To use daily:**
1. Copy RainmeterClone.app to your Applications folder
2. Double-click to launch
3. Drag to position
4. To quit: right-click on desktop widget won't work (it's click-through)
   - Open Activity Monitor (Cmd+Space, type "Activity Monitor")
   - Find "RainmeterClone"
   - Click "X" button to quit

**Pro tip:** Add to Login Items to start automatically:
1. System Settings → General → Login Items
2. Click "+" button
3. Select RainmeterClone.app
4. It will launch every time you log in

---

## CUSTOMIZATION

### Change font size:
Edit `WidgetContentView.swift` and modify the `.font(.custom("AnuratiPro-Regular", size: XX))` values

### Change colors:
Edit `.foregroundColor(.white)` to any color like `.red`, `.blue`, or `.color(Color(red: 1.0, green: 0.5, blue: 0.0))`

### Change date/time format:
Edit `TimeManager` class in `WidgetContentView.swift` and modify the `dateFormat` strings

### Change window size:
Edit `DesktopWidgetWindow.swift` and modify `width: 400, height: 250` values in the initializer

---

**Need more help? Check the README.md file for project structure details.**

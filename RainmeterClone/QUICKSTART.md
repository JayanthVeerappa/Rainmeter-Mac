# 🚀 QUICK START - RainmeterClone

## ⚡ Fastest Path to Running App (10 minutes)

### 1️⃣ Open Xcode (2 min)
```
1. Launch Xcode
2. File → New → Project
3. macOS → App → Next
4. Name: RainmeterClone
5. Interface: SwiftUI
6. Language: Swift
7. Uncheck tests
8. Save to: /Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/
9. Create
```

### 2️⃣ Add Files (3 min)
```
1. Delete ContentView.swift (right-click → Delete → Move to Trash)
2. Open Finder: /Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/RainmeterClone/
3. Select ALL .swift files + Info.plist
4. Drag into Xcode sidebar onto RainmeterClone folder
5. Check "Copy items if needed"
6. Check "RainmeterClone" target
7. Click Finish
```

### 3️⃣ Add Font (2 min)
```
1. Get your AnuratiPro-Regular.otf font file
2. Copy to: RainmeterClone/Resources/Fonts/
3. In Xcode: Right-click RainmeterClone folder → Add Files
4. Navigate to Resources/Fonts/
5. Select font file
6. Check "Copy items" + "RainmeterClone" target
7. Add
```

### 4️⃣ Configure (2 min)
```
1. Click RainmeterClone (blue icon) in left sidebar
2. Select RainmeterClone under TARGETS
3. General tab → Minimum Deployments → macOS: 13.0
4. Info tab → verify LSUIElement exists (or use provided Info.plist)
5. Click font file → Right sidebar → Check "RainmeterClone" under Target Membership
```

### 5️⃣ Run (1 min)
```
1. Press Cmd+R
2. Widget appears on desktop (NOT in Dock)
3. Drag it anywhere
4. Done! 🎉
```

---

## 📋 Files You Have

```
✅ RainmeterCloneApp.swift       - Main entry
✅ AppDelegate.swift              - Lifecycle
✅ DesktopWidgetWindow.swift      - Custom window
✅ WidgetContentView.swift        - UI + time
✅ WindowPositionManager.swift    - Save position
✅ FontLoader.swift               - Load font
✅ Info.plist                     - Configuration
✅ README.md                      - Documentation
✅ XCODE_SETUP_GUIDE.md          - Full tutorial
✅ PROJECT_STRUCTURE.md          - Technical details
```

⚠️ **NEED:** AnuratiPro-Regular.otf in Resources/Fonts/

---

## 🆘 Problems?

**Font not showing?**
- Check font file name matches exactly in code
- Verify Target Membership is checked
- Clean build (Shift+Cmd+K) then rebuild

**Widget invisible?**
- It's hidden from Dock - look at desktop!
- Might be off-screen - delete defaults: `defaults delete com.yourname.RainmeterClone`

**Build errors?**
- Make sure all files were added
- Check macOS deployment target is 13.0+
- Verify Info.plist replaced the default one

**Still stuck?**
→ Read XCODE_SETUP_GUIDE.md for detailed step-by-step with screenshots descriptions

---

## 🎯 What You Get

✨ **Features:**
- Transparent desktop widget
- Shows: DAY / DATE / TIME
- Custom Anurati Pro font
- Draggable anywhere
- Remembers position
- Updates every second
- No Dock icon
- No Cmd+Tab visibility
- Always on desktop layer
- Lightweight (<50MB RAM)

🖥️ **Requirements:**
- macOS Ventura (13.0) or later
- Apple Silicon or Intel Mac
- Xcode 14.0+

---

## 🎨 Customize Later

**Change font size:**
Edit `WidgetContentView.swift` → `.font(.custom("AnuratiPro-Regular", size: XX))`

**Change colors:**
Edit `.foregroundColor(.white)` → `.red`, `.blue`, etc.

**Change format:**
Edit `TimeManager` class → `dateFormat` strings

**Change position:**
Delete saved position: `defaults delete com.yourname.RainmeterClone`

---

## 🏗️ Export Standalone App

```
1. Product → Archive
2. Distribute App → Copy App
3. Choose save location
4. Export
5. Double-click RainmeterClone.app to run
6. If blocked: Right-click → Open (while holding Option)
```

---

**That's it! You now have a Rainmeter-style widget for macOS! 🎉**

For detailed explanations, see XCODE_SETUP_GUIDE.md
For technical details, see PROJECT_STRUCTURE.md

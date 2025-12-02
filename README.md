# Rainmeter-Mac 🎨

A beautiful, Rainmeter-style desktop widget for macOS that displays the day, date, and time with custom typography. Stays on your desktop layer, behind all app windows, just like Rainmeter on Windows.

![macOS](https://img.shields.io/badge/macOS-Sequoia%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

- **Day/Date/Time Display** - Shows current day (spaced letters), date, and time with elegant typography
- **Custom Fonts** - Uses Anurati for day display and Raleway for date/time
- **Desktop Layer** - Stays behind all app windows, just like Rainmeter
- **Transparent & Borderless** - Clean, minimal design that blends with your wallpaper
- **Always Centered** - Automatically centers on your screen
- **No Dock Icon** - Runs quietly in the background
- **Real-time Updates** - Time updates every second
- **macOS Sequoia Compatible** - Uses window level `-1` for proper desktop layering

## 📸 Preview

The widget displays:
```
M  O  N  D  A  Y          ← Spaced Anurati font
December 2, 2025          ← Raleway font  
- 11:45 PM -              ← Raleway font (smaller)
```

## 🚀 Quick Start

### Prerequisites
- macOS Ventura (13.0) or later
- Xcode 15.0 or later
- [Anurati font](https://www.dafont.com/anurati.font) (free download)
- [Raleway font](https://fonts.google.com/specimen/Raleway) (free download)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/JayanthVeerappa/Rainmeter-Mac.git
   cd Rainmeter-Mac/Rainmeter/RainmeterClone
   ```

2. **Open the Xcode project**
   ```bash
   open RainmeterClone.xcodeproj
   ```

3. **Add the font files** (already included in the repo)
   - Fonts are located in `RainmeterClone/` folder
   - `Anurati-Regular.otf` ✅
   - `Raleway.ttf` ✅

4. **Build and Run**
   - Press `Cmd+R` in Xcode
   - The widget will appear centered on your desktop
   - It stays behind all app windows automatically

## 🎨 Customization

### Change Font Sizes
Edit `WidgetContentView.swift`:
```swift
.font(.custom("Anurati-Regular", size: 72))  // Day
.font(.custom("Raleway", size: 32))          // Date
.font(.custom("Raleway", size: 28))          // Time
```

### Change Letter Spacing
```swift
.kerning(30)  // Increase/decrease spacing
```

### Change Colors
```swift
.foregroundColor(.white)  // Change to .red, .blue, etc.
```

### Change Date/Time Format
Edit `TimeManager` in `WidgetContentView.swift`:
```swift
dayFormatter.dateFormat = "EEEE"           // Full day name
dateFormatter.dateFormat = "MMMM d, yyyy"  // Month Day, Year
timeFormatter.dateFormat = "h:mm a"        // 12-hour with AM/PM
```

## 📁 Project Structure

```
RainmeterClone/
├── RainmeterClone.xcodeproj/          # Xcode project
├── RainmeterClone/
│   ├── RainmeterCloneApp.swift        # Main app entry point
│   ├── AppDelegate.swift              # App lifecycle & setup
│   ├── DesktopWidgetWindow.swift      # Custom window (desktop layer)
│   ├── WidgetContentView.swift        # SwiftUI UI & time logic
│   ├── WindowPositionManager.swift    # Position persistence (unused)
│   ├── FontLoader.swift               # Custom font loading
│   ├── Info.plist                     # App configuration
│   ├── Anurati-Regular.otf            # Custom font
│   └── Raleway.ttf                    # Custom font
└── Documentation/                      # Setup guides (in parent folder)
```

## 🔧 Technical Details

### Window Configuration
- **Window Level**: `-1` (below normal windows, macOS Sequoia compatible)
- **Style**: Borderless, transparent, non-activating
- **Collection Behavior**: `.canJoinAllSpaces`, `.stationary`, `.ignoresCycle`
- **Mouse Events**: Click-through (`.ignoresMouseEvents = true`)

### Performance
- **Memory**: ~50MB RAM
- **CPU**: <1% (timer updates every second)
- **Battery Impact**: Minimal

### Compatibility
- ✅ macOS Ventura (13.0)
- ✅ macOS Sonoma (14.0)
- ✅ macOS Sequoia (15.0)
- ✅ Apple Silicon (M1/M2/M3)
- ✅ Intel Macs

## 🐛 Troubleshooting

### Widget doesn't appear
- Click on your desktop or minimize all windows to see it
- Check Console in Xcode for error messages
- Verify fonts loaded: Look for "Successfully registered font" in logs

### Fonts not loading
- Ensure font files are in the project (check Target Membership)
- Verify `Info.plist` has correct font paths
- Clean build folder: `Cmd+Shift+K`, then rebuild

### Widget appears on top of windows
- Verify window level is set to `-1` in `DesktopWidgetWindow.swift`
- Make sure you're on macOS Sonoma/Sequoia (older macOS versions may need different level)

## 📚 Additional Documentation

Detailed guides are available in the `/RainmeterClone/` folder:
- **QUICKSTART.md** - Fast setup guide
- **XCODE_SETUP_GUIDE.md** - Complete beginner tutorial
- **CODE_EXPLAINED.md** - How the code works
- **PROJECT_STRUCTURE.md** - Technical architecture

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Credits

- **Fonts**: 
  - [Anurati](https://www.dafont.com/anurati.font) by Emmeran Richard
  - [Raleway](https://fonts.google.com/specimen/Raleway) by Matt McInerney
- **Inspiration**: [Rainmeter for Windows](https://www.rainmeter.net/)

## 📧 Contact

Created by [Jayanth Veerappa](https://github.com/JayanthVeerappa)

---

**Enjoy your new desktop widget! ⭐ Star this repo if you find it useful!**
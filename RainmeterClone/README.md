# RainmeterClone - macOS Desktop Widget

A lightweight, Rainmeter-style desktop widget for macOS that displays day, date, and time with custom fonts.

## Features
- Transparent, borderless window that stays on desktop layer
- Always-on-top (above wallpaper, behind windows)
- Not visible in Dock or Cmd+Tab
- Draggable to any screen position
- Position persistence using UserDefaults
- Custom font support (Anurati Pro)
- Real-time clock updates every second
- Minimal memory footprint

## Requirements
- macOS Ventura (13.0) or later
- Apple Silicon or Intel Mac
- Xcode 14.0 or later

## Project Structure
```
RainmeterClone/
├── RainmeterCloneApp.swift       # Main app entry point
├── AppDelegate.swift              # App lifecycle management
├── DesktopWidgetWindow.swift      # Custom window configuration
├── WidgetContentView.swift        # SwiftUI UI and time updates
├── WindowPositionManager.swift    # Position persistence
├── FontLoader.swift               # Custom font loading
├── Info.plist                     # App configuration
└── Resources/
    └── Fonts/
        └── AnuratiPro-Regular.otf # Custom font file
```

## Setup Instructions

See the detailed Xcode setup instructions below.

## Building and Running

1. Open the project in Xcode
2. Press Cmd+R to run
3. The widget will appear on your desktop
4. Drag it to your desired position
5. Position is automatically saved

## License

Copyright © 2025. All rights reserved.

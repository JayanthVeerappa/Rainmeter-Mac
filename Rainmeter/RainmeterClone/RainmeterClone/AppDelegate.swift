import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var widgetWindows: [DesktopWidgetWindow] = []
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from Dock and Cmd+Tab
        NSApp.setActivationPolicy(.accessory)
        
        // Load custom font
        FontLoader.loadCustomFont()
        
        // Create widget windows based on monitor settings
        createWidgetsForMonitors()
        
        // Observe monitor changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(monitorsChanged),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
        
        // Observe settings changes
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("MonitorSettingsChanged"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.createWidgetsForMonitors()
        }
    }
    
    @objc func monitorsChanged() {
        // Recreate widgets when monitors change
        let settings = WidgetSettings.shared
        if settings.selectedMonitor == .all {
            createWidgetsForMonitors()
        }
    }
    
    func createWidgetsForMonitors() {
        // Remove existing windows
        widgetWindows.forEach { $0.close() }
        widgetWindows.removeAll()
        
        let settings = WidgetSettings.shared
        
        switch settings.selectedMonitor {
        case .primary:
            // Create widget on primary monitor only
            let window = DesktopWidgetWindow()
            window.orderFrontRegardless()
            widgetWindows.append(window)
            
        case .all:
            // Create widget on all monitors
            for screen in NSScreen.screens {
                let window = DesktopWidgetWindow(screen: screen)
                window.orderFrontRegardless()
                widgetWindows.append(window)
            }
            
        case .custom:
            // For now, same as primary - can extend with UI to select specific monitor
            let window = DesktopWidgetWindow()
            window.orderFrontRegardless()
            widgetWindows.append(window)
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

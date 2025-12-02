import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var widgetWindow: DesktopWidgetWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from Dock and Cmd+Tab
        NSApp.setActivationPolicy(.accessory)
        
        // Load custom font
        FontLoader.loadCustomFont()
        
        // Create and show the widget window at desktop level
        widgetWindow = DesktopWidgetWindow()
        widgetWindow?.orderFrontRegardless()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

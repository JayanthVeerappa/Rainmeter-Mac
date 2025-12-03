import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var widgetWindows: [DesktopWidgetWindow] = []
    var statusItem: NSStatusItem?
    var settingsWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from Dock and Cmd+Tab
        NSApp.setActivationPolicy(.accessory)
        
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "gauge.with.dots.needle.67percent", accessibilityDescription: "Rainmeter Widget")
            button.action = #selector(statusBarButtonClicked)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
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
        // Close and remove existing windows safely
        // Close all windows first
        for window in widgetWindows {
            window.orderOut(nil)
        }
        
        // Small delay to ensure windows are closed before removing references
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            
            // Now remove all references
            self.widgetWindows.removeAll()
            
            let settings = WidgetSettings.shared
            
            switch settings.selectedMonitor {
            case .primary:
                // Create widget on primary monitor only
                let window = DesktopWidgetWindow()
                window.orderFrontRegardless()
                self.widgetWindows.append(window)
                
            case .all:
                // Create widget on all monitors
                for screen in NSScreen.screens {
                    let window = DesktopWidgetWindow(screen: screen)
                    window.orderFrontRegardless()
                    self.widgetWindows.append(window)
                }
                
            case .custom:
                // For now, same as primary - can extend with UI to select specific monitor
                let window = DesktopWidgetWindow()
                window.orderFrontRegardless()
                self.widgetWindows.append(window)
            }
        }
    }
    
    @objc func statusBarButtonClicked() {
        let event = NSApp.currentEvent!
        
        if event.type == .rightMouseUp {
            // Right-click: show menu
            showMenu()
        } else {
            // Left-click: toggle settings
            toggleSettings()
        }
    }
    
    func showMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Settings...", action: #selector(openSettings), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        statusItem?.menu = menu
        statusItem?.button?.performClick(nil)
        statusItem?.menu = nil
    }
    
    @objc func openSettings() {
        toggleSettings()
    }
    
    func toggleSettings() {
        if let window = settingsWindow, window.isVisible {
            window.close()
            settingsWindow = nil
        } else {
            // Temporarily change activation policy to show window
            NSApp.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
            
            let settingsView = SettingsView()
            let hostingController = NSHostingController(rootView: settingsView)
            
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 450, height: 500),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            window.title = "Widget Settings"
            window.contentViewController = hostingController
            window.center()
            window.makeKeyAndOrderFront(nil)
            window.level = .floating
            
            // Reset to accessory when window closes
            NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification, object: window, queue: .main) { _ in
                NSApp.setActivationPolicy(.accessory)
            }
            
            settingsWindow = window
        }
    }
    
    @objc func quitApp() {
        NSApp.terminate(nil)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

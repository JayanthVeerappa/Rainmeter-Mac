import Cocoa
import SwiftUI

class DesktopWidgetWindow: NSWindow {
    private var isDragging = false
    private var dragOffset: NSPoint = .zero
    private var targetScreen: NSScreen?
    
    convenience init(screen: NSScreen) {
        self.init()
        self.targetScreen = screen
        
        // Position on specified screen
        let screenFrame = screen.frame
        let size = WidgetSettings.shared.widgetSize.dimensions
        let centerX = screenFrame.midX - (size.width / 2)
        let centerY = screenFrame.midY - (size.height / 2)
        self.setFrameOrigin(NSPoint(x: centerX, y: centerY))
    }
    
    init() {
        let settings = WidgetSettings.shared
        let size = settings.widgetSize.dimensions
        let initialRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        
        super.init(
            contentRect: initialRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        // CRITICAL FIX for macOS Sonoma/Sequoia: Use level -1
        // This is the ONLY way to keep window behind apps on modern macOS
        self.level = NSWindow.Level(rawValue: -1)
        
        // Transparent window configuration
        self.backgroundColor = .clear
        self.isOpaque = false
        self.hasShadow = false
        
        // Allow interaction for dragging
        self.ignoresMouseEvents = false
        self.isMovableByWindowBackground = true
        
        // Collection behavior: stay on all spaces, stationary, don't cycle
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        
        // Load saved position or center on screen
        let savedPosition = WindowPositionManager.loadPosition()
        self.setFrameOrigin(savedPosition)
        
        // Embed SwiftUI content via NSHostingView
        let contentView = WidgetContentView(window: self)
        self.contentView = NSHostingView(rootView: contentView)
        
        // Observe size changes
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("WidgetSizeChanged"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateSize()
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        isDragging = true
        let windowLocation = self.frame.origin
        let mouseLocation = NSEvent.mouseLocation
        dragOffset = NSPoint(
            x: mouseLocation.x - windowLocation.x,
            y: mouseLocation.y - windowLocation.y
        )
    }
    
    override func rightMouseDown(with event: NSEvent) {
        showContextMenu(at: event.locationInWindow)
    }
    
    func showContextMenu(at location: NSPoint) {
        let menu = NSMenu()
        
        // Size submenu
        let sizeMenu = NSMenu()
        let sizes: [(WidgetSettings.WidgetSize, String)] = [
            (.small, "Small (500×200)"),
            (.medium, "Medium (700×300)"),
            (.large, "Large (900×400)")
        ]
        
        for (size, title) in sizes {
            let item = NSMenuItem(title: title, action: #selector(changeSizeFromMenu(_:)), keyEquivalent: "")
            item.representedObject = size
            item.target = self
            item.state = WidgetSettings.shared.widgetSize == size ? .on : .off
            sizeMenu.addItem(item)
        }
        
        let sizeMenuItem = NSMenuItem(title: "Size", action: nil, keyEquivalent: "")
        sizeMenuItem.submenu = sizeMenu
        menu.addItem(sizeMenuItem)
        
        // Monitor submenu
        let monitorMenu = NSMenu()
        for option in WidgetSettings.MonitorOption.allCases {
            let item = NSMenuItem(title: option.description, action: #selector(changeMonitorFromMenu(_:)), keyEquivalent: "")
            item.representedObject = option
            item.target = self
            item.state = WidgetSettings.shared.selectedMonitor == option ? .on : .off
            monitorMenu.addItem(item)
        }
        
        let monitorMenuItem = NSMenuItem(title: "Display On", action: nil, keyEquivalent: "")
        monitorMenuItem.submenu = monitorMenu
        menu.addItem(monitorMenuItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // Settings
        let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openSettingsFromMenu), keyEquivalent: "")
        settingsItem.target = self
        menu.addItem(settingsItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // Quit
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitFromMenu), keyEquivalent: "")
        quitItem.target = self
        menu.addItem(quitItem)
        
        // Show menu at mouse location
        let windowPoint = self.convertPoint(fromScreen: NSEvent.mouseLocation)
        menu.popUp(positioning: nil, at: windowPoint, in: self.contentView)
    }
    
    @objc func changeSizeFromMenu(_ sender: NSMenuItem) {
        if let size = sender.representedObject as? WidgetSettings.WidgetSize {
            WidgetSettings.shared.widgetSize = size
        }
    }
    
    @objc func changeMonitorFromMenu(_ sender: NSMenuItem) {
        if let option = sender.representedObject as? WidgetSettings.MonitorOption {
            WidgetSettings.shared.selectedMonitor = option
        }
    }
    
    @objc func openSettingsFromMenu() {
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.toggleSettings()
        }
    }
    
    @objc func quitFromMenu() {
        NSApp.terminate(nil)
    }
    
    override func mouseDragged(with event: NSEvent) {
        if isDragging {
            let mouseLocation = NSEvent.mouseLocation
            let newOrigin = NSPoint(
                x: mouseLocation.x - dragOffset.x,
                y: mouseLocation.y - dragOffset.y
            )
            self.setFrameOrigin(newOrigin)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if isDragging {
            isDragging = false
            // Save position when dragging ends
            WindowPositionManager.savePosition(self.frame.origin)
        }
    }
    
    func updateSize() {
        let settings = WidgetSettings.shared
        let newSize = settings.widgetSize.dimensions
        
        // Animate size change
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.allowsImplicitAnimation = true
            self.setContentSize(newSize)
            
            // Update hosting view size
            if let hostingView = self.contentView as? NSHostingView<WidgetContentView> {
                hostingView.setFrameSize(newSize)
            }
        })
    }
    
    // Cannot become key or main (stays in background)
    override var canBecomeKey: Bool {
        return false
    }
    
    override var canBecomeMain: Bool {
        return false
    }
}

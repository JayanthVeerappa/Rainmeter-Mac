import Cocoa
import SwiftUI

class DesktopWidgetWindow: NSWindow {
    init() {
        let initialRect = NSRect(x: 0, y: 0, width: 700, height: 300)
        
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
        
        // Make it click-through (no interaction)
        self.ignoresMouseEvents = true
        
        // Collection behavior: stay on all spaces, stationary, don't cycle
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        
        // Center the window on screen
        if let screen = NSScreen.main {
            let screenFrame = screen.frame
            let centerX = screenFrame.midX - (initialRect.width / 2)
            let centerY = screenFrame.midY - (initialRect.height / 2)
            self.setFrameOrigin(NSPoint(x: centerX, y: centerY))
        }
        
        // Embed SwiftUI content via NSHostingView
        let contentView = WidgetContentView(window: self)
        self.contentView = NSHostingView(rootView: contentView)
    }
    
    // Cannot become key or main (stays in background)
    override var canBecomeKey: Bool {
        return false
    }
    
    override var canBecomeMain: Bool {
        return false
    }
}

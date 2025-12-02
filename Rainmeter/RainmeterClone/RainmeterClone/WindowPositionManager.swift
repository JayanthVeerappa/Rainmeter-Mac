import Foundation
import AppKit

struct WindowPositionManager {
    private static let positionKey = "widgetWindowPosition"
    
    static func savePosition(_ origin: NSPoint) {
        let positionDict: [String: CGFloat] = ["x": origin.x, "y": origin.y]
        UserDefaults.standard.set(positionDict, forKey: positionKey)
    }
    
    static func loadPosition() -> NSPoint {
        if let positionDict = UserDefaults.standard.dictionary(forKey: positionKey) as? [String: CGFloat],
           let x = positionDict["x"],
           let y = positionDict["y"] {
            return NSPoint(x: x, y: y)
        }
        
        // Default position: center-ish of main screen
        if let screen = NSScreen.main {
            let screenFrame = screen.visibleFrame
            return NSPoint(
                x: screenFrame.midX - 200, // half of widget width
                y: screenFrame.midY + 100
            )
        }
        
        return NSPoint(x: 100, y: 100)
    }
}

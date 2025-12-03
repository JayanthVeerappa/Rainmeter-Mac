import Foundation
import AppKit
import Combine

class WidgetSettings: ObservableObject {
    static let shared = WidgetSettings()
    
    @Published var widgetSize: WidgetSize = .medium {
        didSet {
            UserDefaults.standard.set(widgetSize.rawValue, forKey: "widgetSize")
        }
    }
    
    @Published var selectedMonitor: MonitorOption = .primary {
        didSet {
            UserDefaults.standard.set(selectedMonitor.rawValue, forKey: "selectedMonitor")
        }
    }
    
    private init() {
        // Load saved settings
        if let savedSize = UserDefaults.standard.string(forKey: "widgetSize"),
           let size = WidgetSize(rawValue: savedSize) {
            self.widgetSize = size
        }
        
        if let savedMonitor = UserDefaults.standard.string(forKey: "selectedMonitor"),
           let monitor = MonitorOption(rawValue: savedMonitor) {
            self.selectedMonitor = monitor
        }
    }
    
    enum WidgetSize: String, CaseIterable {
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
        case custom = "Custom"
        
        var dimensions: NSSize {
            switch self {
            case .small:
                return NSSize(width: 500, height: 200)
            case .medium:
                return NSSize(width: 700, height: 300)
            case .large:
                return NSSize(width: 900, height: 400)
            case .custom:
                return NSSize(width: 700, height: 300) // Default for custom
            }
        }
        
        var fontSize: (day: CGFloat, date: CGFloat, time: CGFloat) {
            switch self {
            case .small:
                return (day: 48, date: 24, time: 20)
            case .medium:
                return (day: 72, date: 32, time: 28)
            case .large:
                return (day: 96, date: 40, time: 36)
            case .custom:
                return (day: 72, date: 32, time: 28)
            }
        }
    }
    
    enum MonitorOption: String, CaseIterable {
        case primary = "Primary Monitor"
        case all = "All Monitors"
        case custom = "Choose Monitor"
        
        var description: String {
            return self.rawValue
        }
    }
}

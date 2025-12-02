import SwiftUI
import Combine

struct WidgetContentView: View {
    @StateObject private var timeManager = TimeManager()
    weak var window: NSWindow?
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            // Transparent background
            Color.clear
            
            VStack(spacing: 8) {
                // Day of week - Big with letter spacing
                Text(timeManager.dayOfWeek)
                    .font(.custom("Anurati-Regular", size: 72))
                    .kerning(30)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                
                // Date - Raleway font
                Text(timeManager.date)
                    .font(.custom("Raleway", size: 32))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                    .offset(x: -20)
                
                // Time - Smaller with dashes in Raleway
                Text(timeManager.time)
                    .font(.custom("Raleway", size: 28))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                    .offset(x: -20)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Time Manager to update time every second
class TimeManager: ObservableObject {
    @Published var dayOfWeek: String = ""
    @Published var date: String = ""
    @Published var time: String = ""
    
    private var timer: Timer?
    
    init() {
        updateTime()
        // Update every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func updateTime() {
        let now = Date()
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE" // Full day name
        dayOfWeek = dayFormatter.string(from: now).uppercased()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy" // e.g., "December 1, 2025"
        date = dateFormatter.string(from: now)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a" // 12-hour format with AM/PM
        let formattedTime = timeFormatter.string(from: now)
        time = "- \(formattedTime) -"
    }
}

import SwiftUI
import Combine

struct WidgetContentView: View {
    @StateObject private var timeManager = TimeManager()
    @ObservedObject var settings = WidgetSettings.shared
    weak var window: NSWindow?
    @State private var isDragging = false
    @State private var animateTime = false
    
    var body: some View {
        ZStack {
            // Transparent background
            Color.clear
            
            VStack(spacing: 8) {
                // Day of week - Big with letter spacing
                Text(timeManager.dayOfWeek)
                    .font(.custom("Anurati-Regular", size: settings.widgetSize.fontSize.day))
                    .kerning(30)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                    .transition(.opacity)
                
                // Date - Raleway font
                Text(timeManager.date)
                    .font(.custom("Raleway", size: settings.widgetSize.fontSize.date))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                    .offset(x: -20)
                    .transition(.opacity)
                
                // Time - Smaller with dashes in Raleway
                Text(timeManager.time)
                    .font(.custom("Raleway", size: settings.widgetSize.fontSize.time))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .lineLimit(1)
                    .offset(x: -20)
                    .opacity(animateTime ? 1.0 : 0.8)
                    .transition(.opacity)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: timeManager.time) { _ in
            // Animate time update
            withAnimation(.easeInOut(duration: 0.3)) {
                animateTime.toggle()
            }
        }
    }
}

// Time Manager to update time every second (optimized)
class TimeManager: ObservableObject {
    @Published var dayOfWeek: String = ""
    @Published var date: String = ""
    @Published var time: String = ""
    
    private var timer: Timer?
    private var lastDay: String = ""
    private var lastDate: String = ""
    
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
        
        // Only update day if changed (optimization)
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        let newDay = dayFormatter.string(from: now).uppercased()
        if newDay != lastDay {
            dayOfWeek = newDay
            lastDay = newDay
        }
        
        // Only update date if changed (optimization)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let newDate = dateFormatter.string(from: now)
        if newDate != lastDate {
            date = newDate
            lastDate = newDate
        }
        
        // Time updates every second
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let formattedTime = timeFormatter.string(from: now)
        time = "- \(formattedTime) -"
    }
}

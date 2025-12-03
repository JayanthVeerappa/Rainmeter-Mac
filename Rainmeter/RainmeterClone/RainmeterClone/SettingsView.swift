import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = WidgetSettings.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Widget Settings")
                .font(.title)
                .fontWeight(.bold)
            
            Divider()
            
            // Size Selection
            VStack(alignment: .leading, spacing: 10) {
                Text("Widget Size")
                    .font(.headline)
                
                Picker("Size", selection: $settings.widgetSize) {
                    ForEach(WidgetSettings.WidgetSize.allCases, id: \.self) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: settings.widgetSize) { _ in
                    NotificationCenter.default.post(name: NSNotification.Name("WidgetSizeChanged"), object: nil)
                }
                
                Text("Small: 500×200 | Medium: 700×300 | Large: 900×400")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // Monitor Selection
            VStack(alignment: .leading, spacing: 10) {
                Text("Display On")
                    .font(.headline)
                
                Picker("Monitor", selection: $settings.selectedMonitor) {
                    ForEach(WidgetSettings.MonitorOption.allCases, id: \.self) { option in
                        Text(option.description).tag(option)
                    }
                }
                .pickerStyle(.radioGroup)
                .onChange(of: settings.selectedMonitor) { _ in
                    NotificationCenter.default.post(name: NSNotification.Name("MonitorSettingsChanged"), object: nil)
                }
                
                Text("Primary: Main monitor only\nAll Monitors: Widget on every screen")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // Info
            VStack(spacing: 5) {
                Text("💡 Tips")
                    .font(.headline)
                
                Text("• Drag the widget to reposition it")
                Text("• Widget stays behind all app windows")
                Text("• Position is saved automatically")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button("Done") {
                dismiss()
            }
            .keyboardShortcut(.return)
        }
        .padding(30)
        .frame(width: 450, height: 500)
    }
}

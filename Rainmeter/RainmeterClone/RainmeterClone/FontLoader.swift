import Cocoa
import CoreText

struct FontLoader {
    static func loadCustomFont() {
        // Try to load all fonts from the Fonts folder
        let fontNames = ["Anurati-Regular", "Raleway"] // Add more font file names if needed
        
        for fontName in fontNames {
            // Try different extensions
            for ext in ["ttf", "otf"] {
                if let fontURL = Bundle.main.url(forResource: fontName, withExtension: ext, subdirectory: "Fonts") {
                    registerFont(from: fontURL)
                } else if let fontURL = Bundle.main.url(forResource: fontName, withExtension: ext) {
                    registerFont(from: fontURL)
                }
            }
        }
    }
    
    private static func registerFont(from url: URL) {
        var errorRef: Unmanaged<CFError>?
        guard CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef) else {
            if let error = errorRef?.takeRetainedValue() {
                print("Failed to register font: \(url.lastPathComponent), error: \(error)")
            }
            return
        }
        print("Successfully registered font: \(url.lastPathComponent)")
    }
}

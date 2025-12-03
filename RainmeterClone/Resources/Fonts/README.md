# ⚠️ FONT FILE REQUIRED

You need to add your **Anurati Pro** font file here.

## Steps:

1. Download or locate your Anurati Pro font file
2. It should be named: `AnuratiPro-Regular.otf` or `AnuratiPro-Regular.ttf`
3. Copy the font file into this folder: `/Users/Jayanth/Desktop/Rainmeter(Mac)/Rainmeter-Mac/RainmeterClone/Resources/Fonts/`
4. When adding to Xcode:
   - Right-click on RainmeterClone folder
   - Select "Add Files to RainmeterClone..."
   - Navigate to this Fonts folder
   - Select your font file
   - Check "Copy items if needed"
   - Check "RainmeterClone" target
   - Click "Add"

## If you don't have the font:

You can download Anurati Pro from free font websites like:
- Google Fonts
- DaFont
- FontSpace
- or purchase from the official designer

## Alternative fonts:

If you can't find Anurati Pro, you can use any other font:
1. Replace the font file here
2. Update the font name in these files:
   - `WidgetContentView.swift` - Change "AnuratiPro-Regular" to your font name
   - `FontLoader.swift` - Change "AnuratiPro-Regular" to your font name
   - `Info.plist` - Update the UIAppFonts array with your font filename

The font name in code should match the PostScript name of the font, not the filename.

To find the PostScript name:
1. Double-click the font file to open Font Book
2. Look at the PostScript name shown in the preview

---

**Without a font file, the app will fall back to system fonts and still work, just won't look exactly as intended.**

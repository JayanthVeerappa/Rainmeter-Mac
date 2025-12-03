# 🎨 WIDGET VISUAL DESIGN SPEC

This document describes what the final widget looks like and how it behaves.

---

## 📐 Visual Layout

```
╔════════════════════════════════════════╗
║                                        ║
║           MONDAY                       ║  ← Day (64pt Anurati Pro)
║                                        ║
║       December 1, 2025                 ║  ← Date (28pt Anurati Pro)
║                                        ║
║          14:30:45                      ║  ← Time (36pt Anurati Pro)
║                                        ║
╚════════════════════════════════════════╝

Window Size: 400px wide × 250px tall
Background: Transparent (you see your wallpaper through it)
Border: None (borderless window)
All text: White with subtle shadow
```

---

## 🎨 Detailed Specifications

### Day of Week (Top)
- **Font:** Anurati Pro Regular
- **Size:** 64 points
- **Color:** White (#FFFFFF)
- **Shadow:** Black at 30% opacity, 2pt radius, 1pt offset
- **Format:** Full day name in UPPERCASE
- **Examples:** MONDAY, TUESDAY, WEDNESDAY, etc.
- **Updates:** Once per day at midnight

### Date (Middle)
- **Font:** Anurati Pro Regular
- **Size:** 28 points
- **Color:** White (#FFFFFF)
- **Shadow:** Black at 30% opacity, 2pt radius, 1pt offset
- **Format:** Month Day, Year
- **Examples:** December 1, 2025 / January 15, 2026
- **Updates:** Once per day at midnight

### Time (Bottom)
- **Font:** Anurati Pro Regular
- **Size:** 36 points
- **Color:** White (#FFFFFF)
- **Shadow:** Black at 30% opacity, 2pt radius, 1pt offset
- **Format:** 24-hour with seconds (HH:mm:ss)
- **Examples:** 14:30:45 / 09:05:22
- **Updates:** Every second

---

## 🪟 Window Properties

### Visual Properties
- **Width:** 400 pixels
- **Height:** 250 pixels
- **Background Color:** Transparent (clear)
- **Opacity:** Full opacity for text, transparent for background
- **Border:** None
- **Title Bar:** None
- **Buttons:** None (no close/minimize/maximize)
- **Shadow:** None (window has no shadow, but text has shadow)
- **Corners:** Sharp (no rounding)

### Positioning
- **Initial Position:** Center of screen (if no saved position)
- **Saved Position:** Last dragged location (via UserDefaults)
- **Z-Level:** Desktop layer + 1
  - Above wallpaper
  - Below all application windows
  - Below menu bar
  - Below Dock

### Behavior
- **Draggable:** Yes, click and drag anywhere on widget
- **Resizable:** No (fixed size)
- **Closable:** No close button (quit via Activity Monitor or Cmd+Q)
- **Minimizable:** No
- **Click-through:** No (you can interact with it)
- **Focusable:** Yes (receives click events for dragging)
- **Activating:** No (doesn't become "active" window)

---

## 🎭 Visual Examples

### Light Wallpaper (Widget is clearly visible)
```
[Light blue sky wallpaper]

     SUNDAY             ← White text stands out
   July 4, 2025
     12:00:00
```

### Dark Wallpaper (Widget is clearly visible)
```
[Dark space wallpaper]

     FRIDAY            ← White text with shadow visible
  December 25, 2025
     23:59:59
```

### Busy Wallpaper (Shadow helps readability)
```
[Complex colorful wallpaper]

     SATURDAY          ← Shadow provides contrast
   March 15, 2026
     18:45:30
```

---

## 📱 Interaction Design

### Dragging
```
1. User clicks on widget
   └─> Cursor becomes hand/grabbing cursor
   
2. User drags
   └─> Widget moves smoothly with cursor
   └─> No delay or lag
   
3. User releases
   └─> Widget stays at new position
   └─> Position saved to UserDefaults immediately
   └─> Next launch: appears at same spot
```

### Window Stacking
```
[Menu Bar]                 ← Always on top
[Application Windows]      ← Normal windows
[Widget] ← YOU ARE HERE    ← Desktop layer + 1
[Wallpaper]                ← Desktop layer
```

### Multi-Desktop Behavior
```
Desktop 1: [Widget visible]
Desktop 2: [Widget visible]  ← Same widget on all spaces
Desktop 3: [Widget visible]
```

---

## 🎯 Layout Spacing

```
┌─────────────────────────────────────────┐
│  ← 20px padding                         │
│                                         │
│          MONDAY           ← Day         │
│            ↕ 8px spacing                │
│      December 1, 2025     ← Date        │
│            ↕ 8px spacing                │
│         14:30:45          ← Time        │
│                                         │
│                         20px padding →  │
└─────────────────────────────────────────┘
```

**Padding:** 20 pixels on all sides
**Spacing:** 8 pixels between text elements
**Alignment:** All text centered horizontally
**Vertical:** Text stack centered in window

---

## 🎨 Text Shadow Details

```
Shadow Configuration:
├─ Color: Black (RGB: 0, 0, 0)
├─ Opacity: 30% (0.3 alpha)
├─ Blur Radius: 2 points
├─ X Offset: 1 point (right)
└─ Y Offset: 1 point (down)

Visual Effect:
  Original text: WHITE
  Shadow: ☐☐☐ (30% black, slightly below-right)
  
Result: Text appears to "float" above background
```

---

## 🌈 Color Palette

```
Text Color:
  White: #FFFFFF
  RGB: (255, 255, 255)
  HSB: (0°, 0%, 100%)

Shadow Color:
  Black: #000000
  RGB: (0, 0, 0)
  Alpha: 0.3 (30% opacity)
  
Background:
  Transparent: No color
  Alpha: 0.0 (fully transparent)
```

---

## 📏 Responsive Behavior

### Text Overflow (if font too big)
```swift
.lineLimit(1)                    // Single line only
.minimumScaleFactor(0.5)        // Shrink up to 50% if needed
```

### Window Size (fixed, not responsive)
- No auto-resizing
- No adaptive layout
- Fixed 400×250 always

---

## 🖼️ Visual Comparison

### What It's NOT:
❌ Normal app window (no title bar)
❌ Menu bar extra (not in menu bar)
❌ Dock icon (no Dock presence)
❌ Screen overlay (not full-screen)
❌ Notification (not temporary)
❌ Widget in Notification Center (standalone)

### What It IS:
✅ Desktop widget (like Rainmeter)
✅ Always visible layer
✅ Persistent position
✅ Minimal, clean design
✅ Functional clock/calendar

---

## 🎬 Animation & Updates

### Time Updates (every second)
```
14:30:44  →  14:30:45  →  14:30:46
   ↓            ↓            ↓
Instant     Instant      Instant
(no fade or transition)
```

### Date/Day Updates (at midnight)
```
MONDAY         →    TUESDAY
December 1, 2025  →  December 2, 2025
           Instant change at 00:00:00
```

### No Animations:
- No fade-in on launch
- No slide transitions
- No scaling effects
- Instant updates only
- Minimal GPU usage

---

## 🔍 Font Details

### Anurati Pro Characteristics
- **Style:** Geometric, modern, futuristic
- **Weight:** Regular (no bold/light variants in this app)
- **Case:** Uppercase for day (MONDAY), Mixed for date/time
- **Spacing:** Default letter-spacing
- **Rendering:** Anti-aliased, smooth edges

### If Font Doesn't Load
- Falls back to: System font (San Francisco)
- Still readable and functional
- Just not as stylized

---

## 🎚️ Customization Options (for later)

### Easy to Change:
```swift
// In WidgetContentView.swift

Font size:
  Day:  .font(.custom("AnuratiPro-Regular", size: 64))  // ← Change 64
  Date: .font(.custom("AnuratiPro-Regular", size: 28))  // ← Change 28
  Time: .font(.custom("AnuratiPro-Regular", size: 36))  // ← Change 36

Text color:
  .foregroundColor(.white)  // ← Change to .red, .blue, etc.

Shadow:
  .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
          ↑              ↑           ↑      ↑     ↑
       color         opacity      blur  offset offset

Spacing:
  VStack(spacing: 8)  // ← Change 8 to any value

Padding:
  .padding(20)  // ← Change 20 to any value
```

---

## 📐 Actual Pixel Dimensions

### Text Heights (approximate)
```
Day (64pt):    ~85px tall
Date (28pt):   ~37px tall
Time (36pt):   ~48px tall
Spacing (8pt): ~11px each
Padding:       40px total (20px × 2)

Total vertical space used: ~232px (fits in 250px window)
```

### Horizontal Centering
```
400px window width
  ↓
Text centered in available space
  ↓
Padding: 20px left + 20px right = 360px for text
  ↓
Text auto-centers within 360px
```

---

## 🎯 Visual Design Goals

1. **Minimalism:** Clean, simple, distraction-free
2. **Readability:** Clear text at a glance
3. **Integration:** Blends with desktop, doesn't dominate
4. **Functionality:** Shows time/date, nothing more
5. **Consistency:** Same look on light/dark wallpapers
6. **Performance:** Lightweight, no visual lag

---

## 🖥️ Display Compatibility

### Resolution Support
- **Retina Displays:** Full @2x rendering, crisp text
- **Non-Retina:** Standard rendering, still looks good
- **Scaling:** Works at any display scaling setting
- **Multiple Monitors:** Widget stays on monitor where placed

### Size Considerations
- Fixed 400×250 size works on:
  - 1920×1080 screens ✓
  - 2560×1440 screens ✓
  - 3840×2160 (4K) screens ✓
  - Small percentage of screen space
  - Never blocks critical content

---

## 🎨 Design Philosophy

**Inspired by Rainmeter:**
- Minimalist aesthetic
- Desktop integration
- Always visible but unobtrusive
- Customizable (fonts, colors, formats)
- Lightweight and efficient

**macOS Native:**
- Uses system compositor
- Native text rendering
- Respects accessibility settings
- Metal-accelerated if available

---

## 📊 Visual Hierarchy

```
Priority Order (visual weight):

1. DAY OF WEEK       ← Largest (64pt), most prominent
   MONDAY

2. Time              ← Medium-large (36pt), secondary focus
   14:30:45

3. Date              ← Smallest (28pt), tertiary info
   December 1, 2025

Reasoning: Day is most recognizable at a glance,
time changes most frequently (attention-grabbing),
date is stable context.
```

---

## 🎭 States & Variants

### Normal State (99% of the time)
```
White text, subtle shadow
Transparent background
Static position
Updating every second
```

### Dragging State
```
Same visual appearance
Moves with cursor
No special highlight
Smooth motion
```

### No States for:
- Hover (no hover effect)
- Focus (no focus ring)
- Active (never becomes active window)
- Disabled (always enabled)

---

## 📸 Screenshot Specifications

If you were to take a screenshot:
```
File format: PNG with transparency
Resolution: 400×250 @ 2x = 800×500 actual pixels (Retina)
Channels: RGBA (RGB + Alpha)
Color profile: sRGB
Transparency: Yes (for background)
```

---

## 🎨 Accessibility Considerations

### Readable Contrast
- White text on varied backgrounds
- Shadow provides separation
- Large font sizes (64pt/36pt/28pt)
- Clean, legible font

### No Accessibility Barriers
- Text doesn't move/animate
- High contrast available
- Font respects system settings
- No flashing or strobing

### Not Accessible For
- VoiceOver (no accessible text labels in v1.0)
- Screen readers (desktop widget, not standard UI)
- Could be added in future versions

---

## 🎯 Summary

**The widget is:**
- Clean and minimal
- Transparent with white text
- Always visible on desktop
- Shows day, date, time
- Uses custom Anurati Pro font
- Updates every second
- Draggable and persistent

**It looks like:**
- A floating text display
- Part of your desktop
- Unobtrusive but readable
- Professional and polished

---

**This is exactly what you'll see when you run the app! 🎉**

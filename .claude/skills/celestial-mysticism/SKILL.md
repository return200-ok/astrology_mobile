---
name: celestial-mysticism
description: >
  Core architectural skill for the Mystic Cosmos (Tử Vi) Flutter app's "Celestial Mysticism" design system.
  Use this skill whenever working on ANY UI, styling, layout, widget, theme, or visual task in this
  astrology app — including but not limited to: modifying screens/pages, creating or editing widgets,
  changing colors/fonts/spacing, building new features with UI, touching AstroTheme, adding animations,
  working with starfield backgrounds, or adjusting responsive layouts. Also trigger when the user
  mentions "design system", "glass card", "dark theme", "typography", "Cinzel", "Inter font",
  "Ngũ Hành colors", or any screen name (Dashboard, Oracle, Imperial, Chart, Settings, etc.).
  Even if the user just says "make it look better" or "fix the styling" — use this skill.
---

# Celestial Mysticism — Core Design System

You are the Chief Architect of the "Celestial Mysticism" (Huyền học tối giản) design system for a Flutter-based Vietnamese astrology (Tử Vi) app called **Mystic Cosmos**. Every UI decision you make must pass through these principles. They exist because this app serves users who care deeply about both aesthetic atmosphere and data accuracy — getting either wrong damages trust.

## Architecture Overview

```
lib/
├── core/
│   ├── theme/astro_theme.dart    ← Single source of truth for colors, decorations, spacing
│   ├── widgets/                  ← Shared reusable widgets (glass cards, buttons, etc.)
│   └── i18n/                     ← Localization controllers
├── features/
│   ├── oracle/
│   ├── imperial/
│   ├── alignment/
│   ├── iching/
│   ├── soul_revelation/
│   ├── cosmic_void/
│   ├── chart/                    ← The core Tử Vi birth chart (lá số)
│   ├── profile/
│   └── settings/
│       └── each has: domain/ → data/ → presentation/{pages/, widgets/}
└── main.dart
```

## 1. Typography — The Two-Font Rule

The app uses exactly two font families. This isn't arbitrary — Cinzel evokes antiquity and authority (fitting for celestial wisdom), while Inter is one of the most legible UI fonts available (critical for dense astrological data with Vietnamese diacritics).

| Role | Font | Usage | Why |
|------|------|-------|-----|
| **Display** | `Cinzel` | Titles, feature names, celestial terms, headings | Conveys gravitas and mystery — serif strokes echo classical astrology manuscripts |
| **Interface** | `Inter` | Body text, labels, buttons, data tables, descriptions | Maximum legibility at small sizes, excellent Vietnamese diacritic support |

**Applying fonts in code:**
```dart
// Display text — titles, headings, feature names
GoogleFonts.cinzel(fontSize: 24, fontWeight: FontWeight.w700, color: AstroTheme.accentGold)

// Interface text — body, labels, data
GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70)
```

**Legacy fonts to phase out:** If you encounter `CormorantGaramond` or `CinzelDecorative` in existing code, replace them — `CormorantGaramond` → `Inter`, `CinzelDecorative` → `Cinzel`. These were early experiments that created visual inconsistency.

## 2. Color System

### Primary Palette
| Token | Hex | Role |
|-------|-----|------|
| `darkBackground` | `#0a0e27` | App background — deep navy-black, not pure black (pure black feels lifeless) |
| `cosmicPurple` | `#3d1a5c` | Secondary backgrounds, gradient endpoints |
| `navyDeep` | `#1a2f4d` | Card backgrounds, elevated surfaces |
| `accentGold` | `#d4af37` | Primary accent — titles, important highlights, active states |
| `glowPurple` | `#8b5cf6` | Mystical glow effects, secondary accent |
| `glowCyan` | `#06b6d4` | Tertiary accent, data highlights |
| `starYellow` | `#fbbf24` | Star markers, minor highlights |

### Ngũ Hành (Five Elements) — Domain-Specific Colors
These colors represent the five classical elements in Vietnamese astrology. They must be used consistently whenever displaying element-related data:

| Element | Vietnamese | Hex | Usage Context |
|---------|-----------|-----|---------------|
| Metal | Kim (金) | `#d4af37` | Stars/palaces of Kim element |
| Water | Thủy (水) | `#06b6d4` | Stars/palaces of Thủy element |
| Fire | Hỏa (火) | `#f87171` | Stars/palaces of Hỏa element |
| Wood | Mộc (木) | `#34d399` | Stars/palaces of Mộc element |
| Earth | Thổ (土) | `#fca5a5` | Stars/palaces of Thổ element |

**Color usage discipline:** Gold (`accentGold`) is the primary accent. Use it for the single most important element on a screen — not for everything. If everything glows gold, nothing stands out.

## 3. Glass Morphism — The Signature Visual

Every card and container uses a frosted-glass aesthetic. This creates depth without heaviness, letting the cosmic background show through.

```dart
// Use the centralized method:
AstroTheme.glassCardStyle(glow: glowColor)

// Which produces:
BoxDecoration(
  color: Colors.white.withOpacity(0.05),     // Very subtle fill
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.white.withOpacity(0.08)),  // Near-invisible border
  boxShadow: [BoxShadow(color: glowColor.withOpacity(0.15), blurRadius: 8, spreadRadius: 1)],
)
```

**Do not** create one-off card styles in feature pages. If a feature needs a variant (e.g., a card with stronger glow for an active state), add the variant to `AstroTheme` rather than writing inline `BoxDecoration`.

## 4. Spacing & Sizing — The 8px Grid

All spacing derives from an 8px base. This creates visual rhythm without needing to think about individual pixel values.

| Scale | Value | Common Use |
|-------|-------|------------|
| `xs` | 8px | Tight padding, inline gaps |
| `sm` | 16px | Standard padding, card content inset |
| `md` | 24px | Section spacing |
| `lg` | 32px | Major section breaks |
| `xl` | 40px | Page-level margins |
| `xxl` | 48px | Hero spacing |

**Border radius:**
- Cards & containers: `12px`
- Buttons: `8px`
- Chips, tags, badges: `24px` (pill shape)

**Tap targets:** Every interactive element must be at least `44px` in its smallest dimension. This is an accessibility requirement, not a suggestion — small touch targets on astrology apps (which users often consult in low-light, relaxed settings) cause frustration.

**Icon sizing:** `20px` inline with text, `24px` in navigation, `32px` for feature-level icons.

## 5. Tử Vi Terminology — Sacred Text

This is the most critical section. Vietnamese astrology (Tử Vi) has precise terminology developed over centuries. Misspelling a star name or mistranslating a palace name destroys credibility with knowledgeable users.

### The 12 Cung (宮 Palaces) — Never Alter These Names
Mệnh, Huynh Đệ, Phu Thê, Tử Tức, Tài Bạch, Tật Ách, Thiên Di, Nô Bộc, Quan Lộc, Điền Trạch, Phúc Đức, Phụ Mẫu

### The 14 Chính Tinh (正星 Primary Stars) — Exact Spelling Required
Tử Vi, Thiên Cơ, Thái Dương, Vũ Khúc, Thiên Đồng, Liêm Trinh, Thiên Phủ, Thái Âm, Tham Lang, Cự Môn, Thiên Tướng, Thiên Lương, Thất Sát, Phá Quân

### Ngũ Hành (五行 Five Elements)
Kim, Mộc, Thủy, Hỏa, Thổ — always in Vietnamese in the Vietnamese UI. Never substitute with "Metal, Wood, Water, Fire, Earth" in Vietnamese mode.

### Rules
- Check diacritics character by character when writing any Tử Vi term. Vietnamese diacritics change meaning entirely (e.g., "Thân" ≠ "Than" ≠ "Thần").
- When building the English UI, only use translations that exist in the localization ARB files (`lib/l10n/app_en.arb`). Do not invent your own translations.
- If you're unsure about a term, read the relevant localization file first.

## 6. Performance Constraints

These limits exist because the app runs on mid-range Android phones, not just flagship devices.

### Shadows
- **List items / scrollable content:** `BoxShadow(blurRadius: ≤8, spreadRadius: ≤2)` — anything heavier causes visible jank during scroll on older devices.
- **Static cards (non-scrolling):** `BoxShadow(blurRadius: ≤12, spreadRadius: ≤4)` — acceptable because they don't need to be composited on every frame.

### Animations
- **Prefer implicit animations:** `AnimatedContainer`, `AnimatedOpacity`, `AnimatedScale` — Flutter optimizes these internally.
- **Use `AnimationController` only when** you need precise control (e.g., a looping glow pulse). Even then, always `dispose()` it and use `SingleTickerProviderStateMixin` (not `TickerProviderStateMixin` unless you genuinely have multiple controllers).
- **Duration guideline:** 200-300ms for UI transitions, 2-4s for ambient loops (glow, shimmer).

### Starfield Backgrounds
- `CustomPaint` starfields: max **50 stars on mobile** (width < 600px), **100 on tablet/desktop**.
- Stars should be subtle — `opacity: 0.3-0.6`, sizes 1-3px. The background supports the content, it shouldn't compete with it.

### Widget Rebuilds
- Use `const` constructors wherever possible — this is Flutter's primary optimization lever.
- Extract static subtrees into separate `const` widgets rather than nesting them inside `build()` methods that rebuild frequently.

## 7. File Organization Rules

| What | Where | Why |
|------|-------|-----|
| Shared widgets (glass card, cosmic button, etc.) | `lib/core/widgets/` | One source, used everywhere |
| Theme colors, decorations, text styles | `lib/core/theme/` | Centralized so changes propagate |
| Feature-specific widgets | `lib/features/<name>/presentation/widgets/` | Co-located with their feature |
| Feature pages | `lib/features/<name>/presentation/pages/` | Clean architecture convention |

**Anti-patterns to avoid:**
- Defining colors or text styles inline in a page file → extract to `AstroTheme`
- Creating a one-off widget in `core/widgets/` that's only used by one feature → keep it in the feature's `widgets/` directory
- Duplicating a decoration across features → create a shared method in `AstroTheme`

## 8. Tone of Execution

When implementing UI changes:

1. **Content first, decoration second.** If adding a visual effect would obscure astrological data or slow rendering, skip it. Users come to this app for accurate readings, not particle effects.

2. **Consistency over creativity.** Before inventing a new pattern for a screen, check how similar screens handle it. The Oracle page and Imperial page should feel like siblings, not strangers.

3. **Precision with terminology.** Before writing any Tử Vi term into a string, UI label, or comment, verify the spelling against Section 5 above. A single wrong diacritic mark (e.g., "Thiên Cơ" vs "Thiên Cờ") is a bug.

4. **Minimalism with purpose.** Every visual element should justify its existence. Ask: "Does this help the user understand their birth chart better?" If the answer is no, it's decoration — and decoration is only acceptable when it doesn't cost performance.

## Quick Reference Checklist

Before submitting any UI change, verify:

- [ ] Fonts: Only `Cinzel` (display) and `Inter` (interface) — no legacy fonts
- [ ] Colors: From `AstroTheme` constants, not hardcoded hex values
- [ ] Cards: Using `AstroTheme.glassCardStyle()` or an approved variant
- [ ] Spacing: Multiples of 8px
- [ ] Tap targets: ≥ 44px
- [ ] Tử Vi terms: Correct diacritics, verified against Section 5
- [ ] Shadows: Within performance limits (blur ≤12, spread ≤4)
- [ ] Animations: Implicit preferred, controllers disposed
- [ ] Shared styles: Extracted to theme, not inline
- [ ] Vietnamese diacritics: Rendering correctly with Cinzel/Inter

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ══════════════════════════════════════════════════════════════════════════════
// "Thiên Địa Huyền Hoà" — Single source of truth for all colors & typography
//
// Usage:
//   import 'package:astroweb_mobile/core/theme/astro_theme.dart';
//
//   AstroColors.ink          → Đen mực tàu
//   AstroText.pageTitle(28)  → Playfair Display bold, ink
//   AstroSize.title(width)   → responsive font size
// ══════════════════════════════════════════════════════════════════════════════

// ─── Color Palette ───────────────────────────────────────────────────────────
abstract final class AstroColors {
  static const parchment = Color(0xFFF7F3EE); // Kem giấy cổ — background
  static const ink       = Color(0xFF1A1A1A); // Đen mực tàu — primary text
  static const mid       = Color(0xFF5C5C5C); // Chữ phụ — secondary text
  static const light     = Color(0xFF8A8A8A); // Chữ mờ — tertiary text
  static const red       = Color(0xFF801818); // Đỏ huyết dụ — accent (buttons only)
  static const gold      = Color(0xFFA68B5B); // Vàng đồng mờ — accent (decorative only)
  static const card      = Color(0xFFF9F5F0); // Card surface
  static const cardAlt   = Color(0xFFFBF8F3); // Lighter card surface
  static const board     = Color(0xFFF3EDE5); // Board/grid background
  static const border    = Color(0xFFCDC5B8); // Warm-grey border
  static const divider   = Color(0xFFD8D0C6); // Thin divider line
  static const iconBg    = Color(0xFFEAE3D8); // Icon background
}

// ─── Responsive Size Helper ──────────────────────────────────────────────────
abstract final class AstroSize {
  /// Page hero title: 26 → 32 → 40
  static double title(double w)      => w < 430 ? 26 : w < 900 ? 32 : 40;
  /// Large hero title (Enneagram): 30 → 42 → 54
  static double titleLarge(double w) => w < 430 ? 30 : w < 900 ? 42 : 54;
  /// Quote / body: 16 → 20 → 26
  static double quote(double w)      => w < 430 ? 16 : w < 900 ? 20 : 26;
  /// Primary body: 14 → 16
  static double body(double w)       => w < 430 ? 14 : 16;
  /// Filled button label: 14 → 16
  static double button(double w)     => w < 430 ? 14 : 16;
  /// Outline button label: 14 → 18 → 22
  static double buttonLg(double w)   => w < 430 ? 14 : w < 900 ? 18 : 22;
}

// ─── Text Styles ─────────────────────────────────────────────────────────────
abstract final class AstroText {
  // ── Titles ─────────────────────────────────────────────────────────────────

  /// Page hero title — Playfair Display bold, ink
  static TextStyle pageTitle(double size) => GoogleFonts.playfairDisplay(
    color: AstroColors.ink,
    fontSize: size,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.0,
    height: 1.0,
  );

  /// Page subtitle / feature tag — Playfair Display, mid, tracked
  static TextStyle pageSubtitle({double size = 10}) => GoogleFonts.playfairDisplay(
    color: AstroColors.mid,
    fontSize: size,
    letterSpacing: 2.6,
    fontWeight: FontWeight.w500,
  );

  // ── Labels ─────────────────────────────────────────────────────────────────

  /// Section / field label — Playfair Display, mid, tracked caps
  static TextStyle sectionLabel({double size = 12, double spacing = 2.0}) =>
      GoogleFonts.playfairDisplay(
        color: AstroColors.mid,
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: spacing,
      );

  /// Result / trait label — Playfair Display, ink, tracked
  static TextStyle resultLabel({double size = 12}) => GoogleFonts.playfairDisplay(
    color: AstroColors.ink,
    fontSize: size,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.6,
  );

  /// Form field label — Playfair Display, ink, w700, tracked caps
  static TextStyle fieldLabel({double size = 12}) => GoogleFonts.playfairDisplay(
    color: AstroColors.ink,
    fontSize: size,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.0,
  );

  /// Chinese char / element label — Playfair Display, mid
  static TextStyle hanzi({double size = 9}) => GoogleFonts.playfairDisplay(
    color: AstroColors.mid,
    fontSize: size,
    fontWeight: FontWeight.w600,
  );

  /// Micro stamp / badge — Playfair Display, faded mid
  static TextStyle micro({double size = 10, double spacing = 2.0}) =>
      GoogleFonts.playfairDisplay(
        color: AstroColors.mid.withValues(alpha: 0.5),
        fontSize: size,
        letterSpacing: spacing,
      );

  // ── Body ───────────────────────────────────────────────────────────────────

  /// Primary body — Be Vietnam Pro, ink
  static TextStyle body({double size = 14, double height = 1.6}) =>
      GoogleFonts.beVietnamPro(
        color: AstroColors.ink,
        fontSize: size,
        height: height,
      );

  /// Secondary / description body — Be Vietnam Pro, mid
  static TextStyle bodyMuted({double size = 13, double height = 1.65}) =>
      GoogleFonts.beVietnamPro(
        color: AstroColors.mid,
        fontSize: size,
        height: height,
      );

  /// Quote text — Be Vietnam Pro, ink
  static TextStyle quote(double size) => GoogleFonts.beVietnamPro(
    color: AstroColors.ink,
    fontSize: size,
    height: 1.5,
  );

  /// Caption / metadata — Be Vietnam Pro, faded mid
  static TextStyle caption({double size = 11}) => GoogleFonts.beVietnamPro(
    color: AstroColors.mid.withValues(alpha: 0.5),
    fontSize: size,
  );

  // ── Buttons ────────────────────────────────────────────────────────────────

  /// Filled button label — Playfair Display, white, bold
  static TextStyle buttonFilled({double size = 14}) => GoogleFonts.playfairDisplay(
    color: Colors.white,
    fontSize: size,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.8,
  );

  /// Outline button label — Playfair Display, ink, bold
  static TextStyle buttonOutline({double size = 13}) => GoogleFonts.playfairDisplay(
    color: AstroColors.ink,
    fontSize: size,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.0,
  );

  /// Ghost / link action — Playfair Display, mid
  static TextStyle link({double size = 12}) => GoogleFonts.playfairDisplay(
    color: AstroColors.mid,
    fontSize: size,
    letterSpacing: 1.3,
  );

  // ── Score / Progress ───────────────────────────────────────────────────────

  /// Score / numeric value — Playfair Display, mid bold
  static TextStyle score({double size = 12}) => GoogleFonts.playfairDisplay(
    color: AstroColors.mid,
    fontSize: size,
    fontWeight: FontWeight.w700,
  );
}

// ─── Legacy / Chart Compat ───────────────────────────────────────────────────
abstract final class AstroTheme {
  /// Ngũ hành — element colors for Tử Vi chart
  static const Map<String, Color> elementColors = {
    'kim': Color(0xFF8A8A8A), // Kim — xám bạc
    'thuy': Color(0xFF4A7C9E), // Thủy — xanh nước
    'hoa': Color(0xFF9E4A4A), // Hỏa — đỏ nâu
    'moc': Color(0xFF4A7A52), // Mộc — xanh lá
    'tho': Color(0xFFA68B5B), // Thổ — vàng đất
  };
}

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

/// Standardized button widget for the entire app.
///
/// Two variants:
/// - [AstroButton.outline] — white bg, red border (primary action)
/// - [AstroButton.filled] — red bg, white text (emphasized action)
class AstroButton extends StatelessWidget {
  const AstroButton.outline({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.expanded = true,
    this.height = 54.0,
    this.fontSize,
  }) : _filled = false;

  const AstroButton.filled({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.expanded = true,
    this.height = 54.0,
    this.fontSize,
  }) : _filled = true;

  final String label;
  final VoidCallback onTap;
  final Widget? icon;
  final bool expanded;
  final double height;
  final double? fontSize;
  final bool _filled;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final btnFontSize = fontSize ?? AstroSize.button(width);

    final textStyle = _filled
        ? AstroText.buttonFilled(size: btnFontSize)
        : AstroText.buttonOutline(size: btnFontSize);

    final bgColor = _filled ? AstroColors.red : Colors.white;
    final borderColor = AstroColors.red;

    final child = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 10),
        ],
        Text(label, style: textStyle),
      ],
    );

    final button = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        splashColor: AstroColors.red.withValues(alpha: 0.08),
        child: Ink(
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: expanded ? 0 : 32,
            vertical: 0,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Center(child: child),
        ),
      ),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

/// Standardized card container used across all feature pages.
///
/// Consistent border radius (16), border, shadow, and padding.
class AstroCard extends StatelessWidget {
  const AstroCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 16.0,
    this.useGradient = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: useGradient ? null : AstroColors.card,
        gradient: useGradient
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AstroColors.cardAlt, AstroColors.card],
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AstroColors.border.withValues(alpha: 0.7),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AstroColors.ink.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

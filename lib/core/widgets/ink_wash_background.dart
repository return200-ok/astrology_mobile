import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

/// Shared parchment background with subtle red smoke accents.
class InkWashBackground extends StatelessWidget {
  const InkWashBackground({super.key, required this.child});

  final Widget child;

  /// Kem giấy cổ — delegates to AstroColors for single source of truth.
  static const Color parchment = AstroColors.parchment;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    return ColoredBox(
      color: bg,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Subtle red smoke — top-right
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.6, -0.3),
                  radius: 1.2,
                  colors: [
                    AstroColors.red.withValues(alpha: 0.035),
                    AstroColors.red.withValues(alpha: 0.012),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // Subtle red smoke — bottom-left
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.7, 0.8),
                  radius: 0.9,
                  colors: [
                    AstroColors.red.withValues(alpha: 0.025),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

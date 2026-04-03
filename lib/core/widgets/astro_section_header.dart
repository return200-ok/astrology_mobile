import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

/// Standardized section header with red accent line.
///
/// Used consistently across all pages for section titles.
class AstroSectionHeader extends StatelessWidget {
  const AstroSectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.only(bottom: 10),
  });

  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Container(
            width: 16,
            height: 1,
            color: AstroColors.red.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AstroText.micro(size: 11, spacing: 1.8)
                .copyWith(color: AstroColors.light),
          ),
        ],
      ),
    );
  }
}

/// Field label used in forms — consistent across all input pages.
class AstroFieldLabel extends StatelessWidget {
  const AstroFieldLabel({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AstroText.fieldLabel(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class SoulRevelationTabs extends StatelessWidget {
  const SoulRevelationTabs({
    super.key,
    required this.selectedIndex,
    this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = ['BFI-44', l10n.enneagramTitle];

    return Container(
      width: 450,
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AstroColors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AstroColors.border),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final active = index == selectedIndex;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onTabSelected == null ? null : () => onTabSelected!(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? AstroColors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: AstroText.sectionLabel(size: 14, spacing: 1.1).copyWith(
                    color: active ? Colors.white : AstroColors.ink.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

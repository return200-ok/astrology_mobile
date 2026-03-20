import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoulRevelationTabs extends StatelessWidget {
  const SoulRevelationTabs({
    super.key,
    required this.selectedIndex,
    this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;
  static const Color _gold = Color(0xFFFFD438);
  static const List<String> _tabs = ['BFI_44', 'ENNEAGRAM_V9'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B5E),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _gold.withOpacity(0.5)),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final active = index == selectedIndex;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onTabSelected == null ? null : () => onTabSelected!(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? _gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: active ? const Color(0xFF1E1A57) : Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1.1,
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

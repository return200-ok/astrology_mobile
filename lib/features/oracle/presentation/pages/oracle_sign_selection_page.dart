import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/oracle_sign.dart';
import 'oracle_sign_reading_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class OracleSignSelectionPage extends StatelessWidget {
  const OracleSignSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bg,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                        ),
                        color: AstroColors.ink,
                        tooltip: l10n.backTooltip,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    // Red-tinted sparkle — single accent icon
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 15,
                      color: AstroColors.red.withValues(alpha: 0.70),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.oracleTitle,
                            style: AstroText.sectionLabel(size: 16, spacing: 1.8),
                          ),
                          Text(
                            l10n.oracleSelectPrompt,
                            style: AstroText.caption(size: 9),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ── 3×4 Sign grid ────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const cols = 3;
                      const rows = 4;
                      const spacing = 9.0;
                      final tileW = (constraints.maxWidth  - spacing * (cols - 1)) / cols;
                      final tileH = (constraints.maxHeight - spacing * (rows - 1)) / rows;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: oracleSigns.map((sign) {
                          return SizedBox(
                            width: tileW,
                            height: tileH,
                            child: _SignTile(
                              sign: sign,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      OracleSignReadingPage(sign: sign),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sign tile ───────────────────────────────────────────────────────────────

class _SignTile extends StatelessWidget {
  const _SignTile({required this.sign, required this.onTap});

  final OracleSign sign;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AstroColors.card,
          borderRadius: BorderRadius.circular(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Symbol in warm square
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AstroColors.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                sign.symbol,
                style: TextStyle(
                  color: AstroColors.red.withValues(alpha: 0.85),
                  fontSize: 24,
                  height: 1,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Sign name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _titleCase(ZodiacLocalization.name(context, sign.id)),
                  style: AstroText.sectionLabel(size: 12, spacing: 0.6),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 3),

            // Date range
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  ZodiacLocalization.range(context, sign.id),
                  style: AstroText.caption(size: 9),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleCase(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
}

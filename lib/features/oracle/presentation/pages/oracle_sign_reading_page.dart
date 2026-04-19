import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_card.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

import '../../domain/models/oracle_sign.dart';
import 'oracle_ai_chat_page.dart';

class OracleSignReadingPage extends StatelessWidget {
  const OracleSignReadingPage({super.key, required this.sign});

  final OracleSign sign;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AstroPageScaffold(
      backTooltip: l10n.backTooltip,
      horizontalPadding: 16,
      bottomPadding: 36,
      body: Column(
        children: [
          _buildSymbolHeader(context),
          const SizedBox(height: 16),
          _buildMetaCard(context, l10n),
          const SizedBox(height: 14),
          _GenderSection(sign: sign, l10n: l10n),
          const SizedBox(height: 14),
          _buildDecanSection(context, l10n),
          const SizedBox(height: 14),
          _buildLayerSection(context, l10n),
          const SizedBox(height: 20),
          _AskAiButton(sign: sign, l10n: l10n),
        ],
      ),
    );
  }

  // ── Symbol bubble ────────────────────────────────────────────────────────

  Widget _buildSymbolHeader(BuildContext context) {
    return Center(
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: AstroColors.iconBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AstroColors.border, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          sign.symbol,
          style: TextStyle(
            color: AstroColors.red.withValues(alpha: 0.85),
            fontSize: 26,
            height: 1,
          ),
        ),
      ),
    );
  }

  // ── Meta card: name + badges + summary ──────────────────────────────────

  Widget _buildMetaCard(BuildContext context, AppLocalizations l10n) {
    final w = MediaQuery.sizeOf(context).width;
    final titleSize = w < 430 ? 30.0 : 36.0;

    return AstroCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sign name
          Text(
            ZodiacLocalization.name(context, sign.id).toUpperCase(),
            style: AstroText.sectionLabel(size: titleSize, spacing: 3.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Date range
          Text(
            ZodiacLocalization.range(context, sign.id),
            style: AstroText.bodyMuted(size: 13),
          ),
          const SizedBox(height: 12),

          // Element + modality badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Badge(label: sign.element, color: AstroColors.red),
              const SizedBox(width: 8),
              _Badge(label: sign.modality, color: AstroColors.mid),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(
            width: 60,
            height: 1,
            color: AstroColors.red.withValues(alpha: 0.45),
          ),
          const SizedBox(height: 16),

          // Summary
          Text(
            sign.summary,
            textAlign: TextAlign.center,
            style: AstroText.bodyMuted(size: 14, height: 1.65),
          ),
        ],
      ),
    );
  }

  // ── Decan section ────────────────────────────────────────────────────────

  Widget _buildDecanSection(BuildContext context, AppLocalizations l10n) {
    return AstroCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: l10n.oracleDecansTitle),
          _DecanCard(decan: sign.decan1, number: 1, l10n: l10n),
          _DecanCard(decan: sign.decan2, number: 2, l10n: l10n),
          _DecanCard(decan: sign.decan3, number: 3, l10n: l10n),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ── Layer section ────────────────────────────────────────────────────────

  Widget _buildLayerSection(BuildContext context, AppLocalizations l10n) {
    return AstroCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: l10n.oracleLayersTitle),
          _LayerCard(
            label: l10n.oracleSunLabel,
            layer: sign.sunLayer,
            essenceLabel: l10n.oracleEssenceLabel,
            accentColor: AstroColors.red,
          ),
          _LayerCard(
            label: l10n.oracleMoonLabel,
            layer: sign.moonLayer,
            essenceLabel: l10n.oracleEssenceLabel,
            accentColor: AstroColors.mid,
          ),
          _LayerCard(
            label: l10n.oracleRisingLabel,
            layer: sign.risingLayer,
            essenceLabel: l10n.oracleEssenceLabel,
            accentColor: AstroColors.border,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ─── Gender section (stateful toggle) ────────────────────────────────────────

class _GenderSection extends StatefulWidget {
  const _GenderSection({required this.sign, required this.l10n});

  final OracleSign sign;
  final AppLocalizations l10n;

  @override
  State<_GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<_GenderSection> {
  bool _showMale = true;

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final analysis = _showMale ? widget.sign.male : widget.sign.female;

    return AstroCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                _ToggleButton(
                  label: l10n.oracleMaleLabel,
                  selected: _showMale,
                  onTap: () => setState(() => _showMale = true),
                ),
                const SizedBox(width: 8),
                _ToggleButton(
                  label: l10n.oracleFemaleLabel,
                  selected: !_showMale,
                  onTap: () => setState(() => _showMale = false),
                ),
              ],
            ),
          ),

          // Analysis rows
          _AnalysisRow(label: l10n.oraclePersonalityLabel, text: analysis.personality),
          _AnalysisRow(label: l10n.oracleInLoveLabel, text: analysis.inLove),
          _AnalysisRow(label: l10n.oracleCareerLabel, text: analysis.career),
          _AnalysisRow(
            label: l10n.oracleWeaknessLabel,
            text: analysis.weakness,
            labelColor: AstroColors.red.withValues(alpha: 0.75),
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// ─── Decan card ───────────────────────────────────────────────────────────────

class _DecanCard extends StatelessWidget {
  const _DecanCard({required this.decan, required this.number, required this.l10n});

  final SignDecan decan;
  final int number;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AstroColors.divider, thickness: 0.8, height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: decan number + date range + planet
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Badge(label: 'DECAN $number', color: AstroColors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          decan.dateRange,
                          style: AstroText.sectionLabel(size: 11, spacing: 0.5)
                              .copyWith(color: AstroColors.ink),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${l10n.oraclePlanetLabel}: ${decan.planetInfluence}',
                          style: AstroText.bodyMuted(size: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                decan.description,
                style: AstroText.bodyMuted(size: 14, height: 1.6),
              ),
              const SizedBox(height: 10),

              // Strengths
              _InlineRow(
                label: l10n.oracleStrengthsLabel,
                text: decan.strengths,
                labelColor: AstroColors.ink,
              ),
              const SizedBox(height: 6),

              // Weaknesses
              _InlineRow(
                label: l10n.oracleWeaknessesLabel,
                text: decan.weaknesses,
                labelColor: AstroColors.red.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Layer card ───────────────────────────────────────────────────────────────

class _LayerCard extends StatelessWidget {
  const _LayerCard({
    required this.label,
    required this.layer,
    required this.essenceLabel,
    required this.accentColor,
  });

  final String label;
  final SignLayer layer;
  final String essenceLabel;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AstroColors.divider, thickness: 0.8, height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Layer label
              Text(
                label,
                style: AstroText.sectionLabel(size: 11, spacing: 1.8)
                    .copyWith(color: accentColor),
              ),
              const SizedBox(height: 8),

              // Essence headline
              Text(
                layer.essence,
                style: AstroText.sectionLabel(size: 13, spacing: 0.5)
                    .copyWith(color: AstroColors.ink),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                layer.description,
                style: AstroText.bodyMuted(size: 14, height: 1.65),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Text(
        title,
        style: AstroText.sectionLabel(size: 11).copyWith(color: AstroColors.mid),
      ),
    );
  }
}

// ─── Analysis row ─────────────────────────────────────────────────────────────

class _AnalysisRow extends StatelessWidget {
  const _AnalysisRow({
    required this.label,
    required this.text,
    this.labelColor,
    this.isLast = false,
  });

  final String label;
  final String text;
  final Color? labelColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AstroColors.divider, thickness: 0.8, height: 1),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, isLast ? 16 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AstroText.sectionLabel(size: 10, spacing: 1.5)
                    .copyWith(color: labelColor ?? AstroColors.ink),
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: AstroText.bodyMuted(size: 14, height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Inline label + text ──────────────────────────────────────────────────────

class _InlineRow extends StatelessWidget {
  const _InlineRow({
    required this.label,
    required this.text,
    required this.labelColor,
  });

  final String label;
  final String text;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: AstroText.sectionLabel(size: 12, spacing: 0.3)
                .copyWith(color: labelColor),
          ),
          TextSpan(
            text: text,
            style: AstroText.bodyMuted(size: 13, height: 1.55),
          ),
        ],
      ),
    );
  }
}

// ─── Toggle button ────────────────────────────────────────────────────────────

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? AstroColors.red.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? AstroColors.red.withValues(alpha: 0.60)
                : AstroColors.border,
            width: selected ? 1.2 : 0.8,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AstroText.sectionLabel(size: 12, spacing: 1.0).copyWith(
            color: selected
                ? AstroColors.red.withValues(alpha: 0.85)
                : AstroColors.mid,
          ),
        ),
      ),
    );
  }
}

// ─── Badge chip ───────────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Text(
        label,
        style: AstroText.sectionLabel(size: 10, spacing: 0.8)
            .copyWith(color: color.withValues(alpha: 0.85)),
      ),
    );
  }
}

// ─── Ask AI button ────────────────────────────────────────────────────────────

class _AskAiButton extends StatelessWidget {
  const _AskAiButton({required this.sign, required this.l10n});

  final OracleSign sign;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => OracleAiChatPage(sign: sign),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AstroColors.red.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AstroColors.red.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: AstroColors.red.withValues(alpha: 0.80),
            ),
            const SizedBox(width: 8),
            Text(
              l10n.oracleAskAiButton,
              style: AstroText.sectionLabel(size: 12, spacing: 1.5)
                  .copyWith(color: AstroColors.red.withValues(alpha: 0.85)),
            ),
          ],
        ),
      ),
    );
  }
}

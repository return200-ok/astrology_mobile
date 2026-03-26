import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'iching_result_page.dart';

abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const light  = Color(0xFF8A8A8A);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const iconBg = Color(0xFFEAE3D8);
  static const divider = Color(0xFFD8D0C6);
  static const sheet  = Color(0xFFF2EDE4);
}

class IChingInputPage extends StatefulWidget {
  const IChingInputPage({super.key});

  @override
  State<IChingInputPage> createState() => _IChingInputPageState();
}

class _IChingInputPageState extends State<IChingInputPage> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    color: _P.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.ichingTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.ink,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.ichingSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: _P.mid,
                    fontSize: 13,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 36),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 860;
        if (narrow) {
          return Column(
            children: [
              _InputCard(
                queryController: _queryController,
                onCast: _castYarrowStalks,
              ),
              const SizedBox(height: 16),
              const _AltarCard(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InputCard(
                queryController: _queryController,
                onCast: _castYarrowStalks,
              ),
            ),
            const SizedBox(width: 18),
            const Expanded(
              child: _AltarCard(),
            ),
          ],
        );
      },
    );
  }

  void _castYarrowStalks() {
    final l10n = AppLocalizations.of(context)!;
    final query = _queryController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.ichingQueryRequiredSnack)),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => IChingResultPage(query: query),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.queryController,
    required this.onCast,
  });

  final TextEditingController queryController;
  final VoidCallback onCast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final hintSize = width < 430 ? 24.0 : 28.0;
    final buttonSize = width < 430 ? 18.0 : 22.0;

    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: _P.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.ichingWhisperQueryLabel,
            style: GoogleFonts.cinzel(
              color: _P.mid,
              fontSize: 15,
              letterSpacing: 2.1,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: queryController,
            cursorColor: _P.red,
            style: GoogleFonts.inter(
              color: _P.ink,
              fontSize: 26,
            ),
            decoration: InputDecoration(
              hintText: l10n.ichingWhisperQueryHint,
              hintStyle: GoogleFonts.inter(
                color: _P.light,
                fontSize: hintSize,
              ),
              filled: true,
              fillColor: _P.sheet,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: _P.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: _P.red, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCast,
              style: OutlinedButton.styleFrom(
                foregroundColor: _P.red,
                side: const BorderSide(color: _P.red),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.auto_awesome_rounded, size: 20),
              label: Text(
                l10n.ichingCastYarrowStalks,
                style: GoogleFonts.cinzel(
                  fontSize: buttonSize,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AltarCard extends StatelessWidget {
  const _AltarCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      constraints: const BoxConstraints(minHeight: 420),
      decoration: BoxDecoration(
        color: _P.card,
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _P.border),
            ),
          ),
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _P.border.withValues(alpha: 0.6)),
            ),
          ),
          Positioned(
            bottom: 14,
            child: Text(
              l10n.ichingAltarReady,
              style: GoogleFonts.cinzel(
                color: _P.light,
                fontSize: 16,
                letterSpacing: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

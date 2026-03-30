import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import 'iching_result_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class IChingInputPage extends StatefulWidget {
  const IChingInputPage({super.key});

  @override
  State<IChingInputPage> createState() => _IChingInputPageState();
}

class _IChingInputPageState extends State<IChingInputPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final subtitleSize = width < 430 ? 12.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.2 : 4.4;

    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    color: AstroColors.ink,
                  ),
                ),
                Text(
                  l10n.ichingTitle,
                  textAlign: TextAlign.center,
                  style: AstroText.pageTitle(AstroSize.title(width)),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.ichingSubtitle,
                  textAlign: TextAlign.center,
                  style: AstroText.pageSubtitle(size: subtitleSize),
                ),
                const SizedBox(height: 36),
                _buildBody(),
              ],
            ),
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
    if (!_formKey.currentState!.validate()) return;
    final query = _queryController.text.trim();

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
    final hintSize = width < 430 ? 22.0 : 26.0;
    final buttonSize = width < 430 ? 16.0 : 20.0;

    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: AstroColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AstroColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.ichingWhisperQueryLabel,
            style: AstroText.sectionLabel(size: 14, spacing: 2.1),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: queryController,
            maxLength: 200,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[<>&]')),
            ],
            validator: (value) {
              final v = value?.trim() ?? '';
              if (v.isEmpty) return 'Vui lòng nhập câu hỏi';
              if (v.length < 3) return 'Câu hỏi phải có ít nhất 3 ký tự';
              return null;
            },
            style: AstroText.quote(22),
            decoration: InputDecoration(
              hintText: l10n.ichingWhisperQueryHint,
              hintStyle: AstroText.bodyMuted(size: hintSize).copyWith(color: AstroColors.mid.withValues(alpha: 0.5)),
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AstroColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AstroColors.red.withValues(alpha: 0.6), width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AstroColors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AstroColors.red, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCast,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AstroColors.red,
                side: const BorderSide(color: AstroColors.red, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.auto_awesome_rounded, size: 20),
              label: Text(
                l10n.ichingCastYarrowStalks,
                style: AstroText.buttonOutline(size: buttonSize).copyWith(letterSpacing: 1.7),
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
        color: AstroColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AstroColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AstroColors.border.withValues(alpha: 0.3)),
            ),
          ),
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AstroColors.border.withValues(alpha: 0.2)),
            ),
          ),
          Positioned(
            bottom: 14,
            child: Text(
              l10n.ichingAltarReady,
              style: AstroText.micro(size: 16, spacing: 5),
            ),
          ),
        ],
      ),
    );
  }
}

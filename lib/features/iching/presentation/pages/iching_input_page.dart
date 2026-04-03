import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/core/widgets/astro_card.dart';

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

    return AstroPageScaffold(
      horizontalPadding: 20,
      bottomPadding: 30,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 860;
        if (narrow) {
          return _InputCard(
            queryController: _queryController,
            onCast: _castYarrowStalks,
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

    return AstroCard(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 210),
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
                  borderSide: const BorderSide(color: AstroColors.border, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AstroColors.red.withValues(alpha: 0.5), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AstroColors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AstroColors.red, width: 1.2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            AstroButton.outline(
              label: l10n.ichingCastYarrowStalks,
              onTap: onCast,
              icon: Icon(Icons.auto_awesome_rounded, size: 20, color: AstroColors.red),
              fontSize: buttonSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _AltarCard extends StatelessWidget {
  const _AltarCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AstroCard(
      padding: EdgeInsets.zero,
      borderRadius: 24,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 420),
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
      ),
    );
  }
}

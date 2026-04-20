import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:astroweb_mobile/core/services/ai_chat_service.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';

import '../../domain/models/imperial_cast_request.dart';

class ImperialAnalysisPage extends StatefulWidget {
  const ImperialAnalysisPage({super.key, required this.request});

  final ImperialCastRequest request;

  @override
  State<ImperialAnalysisPage> createState() => _ImperialAnalysisPageState();
}

class _ImperialAnalysisPageState extends State<ImperialAnalysisPage> {
  bool _loading = true;
  String? _answer;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final answer = await AiChatService.analyzeImperial(request: widget.request);
      if (!mounted) return;
      setState(() {
        _answer = answer;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('dd/MM/yyyy').format(widget.request.arrivalDay);

    return AstroPageScaffold(
      horizontalPadding: 20,
      topPadding: 4,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.imperialAnalysisTitle,
            textAlign: TextAlign.center,
            style: AstroText.resultLabel(size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.imperialAnalysisSubtitle,
            textAlign: TextAlign.center,
            style: AstroText.pageSubtitle(size: 12),
          ),
          const SizedBox(height: 14),

          // Identity card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AstroColors.cardAlt,
              border: Border.all(color: AstroColors.border, width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IdentityRow(label: l10n.imperialResultIdentity, value: widget.request.spiritId),
                const SizedBox(height: 4),
                _IdentityRow(label: l10n.imperialResultDate, value: dateStr),
                const SizedBox(height: 4),
                _IdentityRow(label: l10n.imperialResultHour, value: widget.request.streamHour),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Disclaimer
          Container(
            width: double.infinity,
            color: AstroColors.iconBg,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              l10n.imperialAnalysisDisclaimer,
              textAlign: TextAlign.center,
              style: AstroText.caption(size: 11).copyWith(color: AstroColors.mid),
            ),
          ),

          const SizedBox(height: 16),

          // Body
          if (_loading) const _LoadingView(),
          if (_error != null) _ErrorView(message: _error!, onRetry: _load),
          if (_answer != null) _AnalysisBody(text: _answer!),
        ],
      ),
    );
  }
}

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label:', style: AstroText.sectionLabel(size: 11, spacing: 1.4)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: AstroText.body(size: 13),
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AstroColors.red),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.imperialAnalysisLoading,
            textAlign: TextAlign.center,
            style: AstroText.bodyMuted(size: 13),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(
            l10n.imperialAnalysisError,
            textAlign: TextAlign.center,
            style: AstroText.body(size: 14).copyWith(color: AstroColors.red),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AstroText.caption(size: 11),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          AstroButton.outline(
            label: l10n.imperialAnalysisRetry,
            onTap: onRetry,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

class _AnalysisBody extends StatelessWidget {
  const _AnalysisBody({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final blocks = _parseBlocks(text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final block in blocks) ...[
          if (block.isHeading)
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 6),
              child: Text(
                block.text,
                style: AstroText.resultLabel(size: 14)
                    .copyWith(color: AstroColors.red),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                block.text,
                style: AstroText.body(size: 14, height: 1.7),
              ),
            ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  // Lightweight parser: lines that look like ALL-CAPS headings (with optional
  // leading number/markdown markers) become section titles. Everything else is
  // body. Blank lines are collapsed.
  List<_Block> _parseBlocks(String raw) {
    final lines = raw.split('\n');
    final out = <_Block>[];
    final paragraph = StringBuffer();

    void flushParagraph() {
      final p = paragraph.toString().trim();
      if (p.isNotEmpty) out.add(_Block(p, isHeading: false));
      paragraph.clear();
    }

    for (final lineRaw in lines) {
      final line = lineRaw.trim();
      if (line.isEmpty) {
        flushParagraph();
        continue;
      }
      // Strip common markdown markers
      var stripped = line
          .replaceAll(RegExp(r'^#+\s*'), '')
          .replaceAll(RegExp(r'^\*+'), '')
          .replaceAll(RegExp(r'\*+$'), '')
          .replaceAll(RegExp(r'^\d+[.)]\s*'), '')
          .trim();

      final letters = stripped.replaceAll(RegExp(r'[^A-Za-zÀ-ỹ]'), '');
      final isHeading = letters.length >= 3 &&
          letters == letters.toUpperCase() &&
          stripped.length <= 60;

      if (isHeading) {
        flushParagraph();
        out.add(_Block(stripped, isHeading: true));
      } else {
        if (paragraph.isNotEmpty) paragraph.write(' ');
        paragraph.write(stripped);
      }
    }
    flushParagraph();
    return out;
  }
}

class _Block {
  const _Block(this.text, {required this.isHeading});
  final String text;
  final bool isHeading;
}

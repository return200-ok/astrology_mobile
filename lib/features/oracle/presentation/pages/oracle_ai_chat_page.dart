import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/services/ai_chat_service.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

import '../../domain/models/oracle_sign.dart';

// Maximum questions allowed per chat session
const _kMaxQuestions = 5;

class OracleAiChatPage extends StatefulWidget {
  const OracleAiChatPage({super.key, required this.sign});

  final OracleSign sign;

  @override
  State<OracleAiChatPage> createState() => _OracleAiChatPageState();
}

class _OracleAiChatPageState extends State<OracleAiChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;
  int _questionCount = 0;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool get _atLimit => _questionCount >= _kMaxQuestions;

  Future<void> _send(String text) async {
    final question = text.trim();
    if (question.isEmpty || _isLoading || _atLimit) return;

    _textController.clear();
    setState(() {
      _messages.add(_ChatMessage(text: question, isUser: true));
      _isLoading = true;
      _questionCount++;
    });
    _scrollToBottom();

    try {
      final answer = await AiChatService.ask(
        question: question,
        sign: widget.sign,
      );
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatMessage(text: answer, isUser: false));
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatMessage(
          text: 'Có lỗi xảy ra, vui lòng thử lại.',
          isUser: false,
          isError: true,
        ));
        _isLoading = false;
        _questionCount--; // refund on error
      });
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: SafeArea(
        child: Column(
          children: [
            _Header(sign: widget.sign, l10n: l10n),
            Expanded(child: _buildMessages(l10n)),
            _buildInput(l10n),
          ],
        ),
      ),
    );
  }

  // ── Messages area ─────────────────────────────────────────────────────────

  Widget _buildMessages(AppLocalizations l10n) {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        if (_messages.isEmpty) _SuggestedQuestions(onTap: _send, l10n: l10n),
        ..._messages.map((m) => _BubbleTile(message: m)),
        if (_isLoading) const _ThinkingBubble(),
        if (_atLimit && !_isLoading) _LimitBanner(l10n: l10n),
        const SizedBox(height: 8),
      ],
    );
  }

  // ── Input row ─────────────────────────────────────────────────────────────

  Widget _buildInput(AppLocalizations l10n) {
    final canSend = !_atLimit && !_isLoading;

    return Container(
      decoration: BoxDecoration(
        color: AstroColors.card,
        border: Border(
          top: BorderSide(color: AstroColors.divider, width: 0.8),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              enabled: canSend,
              onSubmitted: _send,
              maxLines: 3,
              minLines: 1,
              textInputAction: TextInputAction.send,
              style: AstroText.body(size: 14).copyWith(color: AstroColors.ink),
              decoration: InputDecoration(
                hintText: l10n.oracleAiHint,
                hintStyle: AstroText.bodyMuted(size: 13),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                filled: true,
                fillColor: AstroColors.cardAlt,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AstroColors.border, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AstroColors.red.withValues(alpha: 0.55),
                    width: 1.2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AstroColors.border.withValues(alpha: 0.4),
                    width: 0.8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _SendButton(
            enabled: canSend,
            onTap: () => _send(_textController.text),
          ),
        ],
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.sign, required this.l10n});

  final OracleSign sign;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 16, 4),
          child: Row(
            children: [
              // Back button
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AstroColors.ink),
                tooltip: l10n.backTooltip,
                onPressed: () => Navigator.of(context).pop(),
              ),

              // Sign symbol bubble
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AstroColors.iconBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AstroColors.border, width: 0.8),
                ),
                alignment: Alignment.center,
                child: Text(
                  sign.symbol,
                  style: TextStyle(
                    color: AstroColors.red.withValues(alpha: 0.85),
                    fontSize: 17,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.oracleAiTitle,
                      style: AstroText.sectionLabel(size: 11, spacing: 1.2)
                          .copyWith(color: AstroColors.mid),
                    ),
                    Text(
                      sign.name,
                      style: AstroText.sectionLabel(size: 14, spacing: 0.8),
                    ),
                  ],
                ),
              ),

              // AI badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AstroColors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AstroColors.red.withValues(alpha: 0.30),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  'AI',
                  style: AstroText.sectionLabel(size: 10, spacing: 1.5)
                      .copyWith(color: AstroColors.red.withValues(alpha: 0.75)),
                ),
              ),
            ],
          ),
        ),
        Divider(color: AstroColors.divider, thickness: 0.8, height: 1),
        _DisclaimerBanner(l10n: l10n),
      ],
    );
  }
}

// ─── Disclaimer banner ────────────────────────────────────────────────────────

class _DisclaimerBanner extends StatelessWidget {
  const _DisclaimerBanner({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AstroColors.iconBg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        l10n.oracleAiDisclaimer,
        textAlign: TextAlign.center,
        style: AstroText.micro().copyWith(
          color: AstroColors.mid,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─── Suggested questions ──────────────────────────────────────────────────────

class _SuggestedQuestions extends StatelessWidget {
  const _SuggestedQuestions({required this.onTap, required this.l10n});

  final void Function(String) onTap;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      l10n.oracleAiSuggest1,
      l10n.oracleAiSuggest2,
      l10n.oracleAiSuggest3,
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            l10n.oracleAiTitle,
            style: AstroText.sectionLabel(size: 11, spacing: 1.5)
                .copyWith(color: AstroColors.mid),
          ),
          const SizedBox(height: 14),
          ...suggestions.map(
            (q) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => onTap(q),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: AstroColors.card,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AstroColors.border, width: 0.8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          q,
                          style: AstroText.body(size: 13)
                              .copyWith(color: AstroColors.ink),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 12, color: AstroColors.mid),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chat bubble ─────────────────────────────────────────────────────────────

class _BubbleTile extends StatelessWidget {
  const _BubbleTile({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final isError = message.isError;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.only(right: 8, bottom: 2),
              decoration: BoxDecoration(
                color: AstroColors.iconBg,
                shape: BoxShape.circle,
                border:
                    Border.all(color: AstroColors.border, width: 0.8),
              ),
              alignment: Alignment.center,
              child: Text(
                '✦',
                style: TextStyle(
                  fontSize: 10,
                  color: AstroColors.red.withValues(alpha: 0.75),
                ),
              ),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? AstroColors.red.withValues(alpha: 0.08)
                    : isError
                        ? AstroColors.border.withValues(alpha: 0.3)
                        : AstroColors.card,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: Radius.circular(isUser ? 12 : 3),
                  bottomRight: Radius.circular(isUser ? 3 : 12),
                ),
                border: Border.all(
                  color: isUser
                      ? AstroColors.red.withValues(alpha: 0.25)
                      : AstroColors.border,
                  width: 0.8,
                ),
              ),
              child: Text(
                message.text,
                style: AstroText.body(size: 14).copyWith(
                  color: isUser
                      ? AstroColors.ink
                      : isError
                          ? AstroColors.mid
                          : AstroColors.ink,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Thinking bubble ─────────────────────────────────────────────────────────

class _ThinkingBubble extends StatelessWidget {
  const _ThinkingBubble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.only(right: 8, bottom: 2),
            decoration: BoxDecoration(
              color: AstroColors.iconBg,
              shape: BoxShape.circle,
              border: Border.all(color: AstroColors.border, width: 0.8),
            ),
            alignment: Alignment.center,
            child: Text(
              '✦',
              style: TextStyle(
                fontSize: 10,
                color: AstroColors.red.withValues(alpha: 0.75),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AstroColors.card,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(3),
              ),
              border: Border.all(color: AstroColors.border, width: 0.8),
            ),
            child: SizedBox(
              width: 36,
              child: LinearProgressIndicator(
                backgroundColor: AstroColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AstroColors.red.withValues(alpha: 0.55),
                ),
                minHeight: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Limit banner ─────────────────────────────────────────────────────────────

class _LimitBanner extends StatelessWidget {
  const _LimitBanner({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AstroColors.border.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            l10n.oracleAiSessionLimit(_kMaxQuestions),
            style: AstroText.bodyMuted(size: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ─── Send button ──────────────────────────────────────────────────────────────

class _SendButton extends StatelessWidget {
  const _SendButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled
              ? AstroColors.red.withValues(alpha: 0.85)
              : AstroColors.border,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.arrow_upward_rounded,
          size: 20,
          color: enabled ? Colors.white : AstroColors.mid,
        ),
      ),
    );
  }
}

// ─── Data model ───────────────────────────────────────────────────────────────

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
  });

  final String text;
  final bool isUser;
  final bool isError;
}

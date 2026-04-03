import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

/// Standardized page scaffold for all feature pages.
///
/// Provides: Scaffold → InkWashBackground → SafeArea → back button + content.
/// Ensures consistent background, back button style, and page padding.
class AstroPageScaffold extends StatelessWidget {
  const AstroPageScaffold({
    super.key,
    required this.body,
    this.backTooltip,
    this.showBackButton = true,
    this.horizontalPadding = 24.0,
    this.topPadding = 0.0,
    this.bottomPadding = 40.0,
    this.scrollable = true,
  });

  final Widget body;
  final String? backTooltip;
  final bool showBackButton;
  final double horizontalPadding;
  final double topPadding;
  final double bottomPadding;

  /// Whether body is wrapped in SingleChildScrollView.
  /// Set false for pages that manage their own scrolling (e.g. Column + Expanded).
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;

    Widget content = Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      child: body,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: bg,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showBackButton)
                _BackButton(tooltip: backTooltip),
              if (scrollable)
                Expanded(child: content)
              else
                Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}

/// Consistent back button used across all pages.
class _BackButton extends StatelessWidget {
  const _BackButton({this.tooltip});
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 44,
          height: 44,
          child: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            color: AstroColors.ink,
            tooltip: tooltip,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

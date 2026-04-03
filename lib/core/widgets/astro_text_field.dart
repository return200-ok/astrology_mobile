import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

/// Standardized pill-shaped text field (single line).
class AstroTextField extends StatelessWidget {
  const AstroTextField({
    super.key,
    required this.controller,
    this.hint,
    this.maxLength = 50,
    this.validator,
    this.style,
    this.hintStyle,
  });

  final TextEditingController controller;
  final String? hint;
  final int maxLength;
  final FormFieldValidator<String>? validator;
  final TextStyle? style;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[<>&"' "'" r']')),
      ],
      validator: validator,
      style: style ?? AstroText.body(size: 15),
      cursorColor: AstroColors.red,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle ?? AstroText.caption(size: 15),
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        filled: true,
        fillColor: AstroColors.card,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.border, width: 0.8),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AstroColors.red.withValues(alpha: 0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.red, width: 1),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.red, width: 1.2),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

/// Standardized multi-line text area with rounded corners.
class AstroTextArea extends StatelessWidget {
  const AstroTextArea({
    super.key,
    required this.controller,
    this.hint,
    this.maxLength = 500,
    this.minLines = 4,
    this.maxLines = 6,
    this.validator,
  });

  final TextEditingController controller;
  final String? hint;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      style: AstroText.quote(14),
      cursorColor: AstroColors.red,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AstroText.bodyMuted(size: 14),
        counterText: '',
        contentPadding: const EdgeInsets.all(20),
        filled: true,
        fillColor: AstroColors.card,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.border, width: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AstroColors.red.withValues(alpha: 0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.red, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AstroColors.red, width: 1.2),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

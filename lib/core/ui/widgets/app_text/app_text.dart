import 'package:code_quality_demo/core/ui/localization/localization_viewmodel.dart';
import 'package:flutter/material.dart';

/// A standardized text widget for the application.
class AppText extends StatelessWidget {
  /// The text content to display.
  final String text;

  /// The text style to apply.
  final TextStyle? style;

  /// Creates a text widget.
  const AppText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final translatedText = LocalizationViewModel.instance.translate(text);
    return Text(translatedText, style: style);
  }
}

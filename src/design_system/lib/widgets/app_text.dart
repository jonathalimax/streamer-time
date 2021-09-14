import 'package:design_system/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const AppText.heading1(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsHeading1Style;

  const AppText.heading2(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsHeading2Style;

  const AppText.heading3(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsHeading3Style;

  const AppText.heading4(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsHeading4Style;

  const AppText.headline(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsHeadlineStyle;

  const AppText.subheading(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsSubheadingStyle;

  const AppText.caption(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsCaptionStyle;

  const AppText.body(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = ktsBodyStyle;

  AppText(
    this.text, {
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

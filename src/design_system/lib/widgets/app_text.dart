import 'package:design_system/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? textAlign;

  const AppText.heading1(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsHeading1Style;

  const AppText.heading2(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsHeading2Style;

  const AppText.heading3(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsHeading3Style;

  const AppText.heading4(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsHeading4Style;

  const AppText.headline(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsHeadlineStyle;

  const AppText.subheading(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsSubheadingStyle;

  const AppText.caption(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsCaptionStyle;

  const AppText.body(
    this.text, {
    this.color,
    this.textAlign,
  }) : style = ktsBodyStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}

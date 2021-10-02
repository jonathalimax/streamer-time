import 'package:design_system/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool hasShadow;

  const AppText.heading1(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsHeading1Style;

  const AppText.heading2(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsHeading2Style;

  const AppText.heading3(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsHeading3Style;

  const AppText.heading4(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsHeading4Style;

  const AppText.headline(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsHeadlineStyle;

  const AppText.subheading(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsSubheadingStyle;

  const AppText.caption(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsCaptionStyle;

  const AppText.captionBold(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsCaptionBoldStyle;

  const AppText.body(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsBodyStyle;

  const AppText.bodyBold(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  }) : style = ktsBodyBoldStyle;

  AppText(
    this.text, {
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
        shadows: <Shadow>[
          if (hasShadow)
            Shadow(
              offset: Offset(.1, .1),
              blurRadius: 15.0,
              color: Colors.black,
            ),
        ],
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

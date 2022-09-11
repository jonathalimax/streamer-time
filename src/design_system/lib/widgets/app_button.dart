import 'package:design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color color;
  final bool outlined;
  final VoidCallback action;

  const AppButton.outlined({
    required this.title,
    required this.action,
    this.titleColor,
    this.color = kcIceWhite,
  }) : outlined = true;

  const AppButton({
    required this.title,
    required this.action,
    this.titleColor,
    this.color = kcIceWhite,
  }) : outlined = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: !outlined
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            )
          : BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: color,
                width: 1.5,
              ),
            ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ElevatedButton(
            onPressed: action,
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: titleColor ?? kcIceWhite,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              onPrimary: kcLightPurple,
            ),
          ),
        ],
      ),
    );
  }
}

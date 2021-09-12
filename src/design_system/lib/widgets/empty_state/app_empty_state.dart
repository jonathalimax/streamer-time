import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:design_system/widgets/empty_state/app_empty_state_type.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonTitle;
  final Function? buttonAction;
  final AppEmptyStateType type;

  const AppEmptyState({
    required this.title,
    required this.type,
    this.subtitle,
    this.buttonTitle,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Spacer(flex: 2),
            Container(
              height: 150,
              width: 300,
              child: Image(
                image: AssetImage(type.path, package: 'design_system'),
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              flex: 0,
              child: Container(
                alignment: Alignment.topCenter,
                width: 350,
                child: AppText.heading4(title),
              ),
            ),
            if (subtitle != null)
              Column(
                children: <Widget>[
                  SizedBox(height: 18),
                  Container(
                    width: 350,
                    child: Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            if (buttonTitle != null && buttonAction != null)
              Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  AppButton(
                    title: buttonTitle!,
                    action: () => buttonAction!(),
                  ),
                ],
              ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

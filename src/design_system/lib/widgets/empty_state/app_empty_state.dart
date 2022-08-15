import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:design_system/widgets/empty_state/app_empty_state_type.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonTitle;
  final Function? buttonAction;
  final AppEmptyStateType? type;

  const AppEmptyState({
    required this.title,
    this.type,
    this.subtitle,
    this.buttonTitle,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            if (type != null)
              Image(
                image: AssetImage(type!.path, package: 'design_system'),
                height: 190,
                width: 190,
                fit: BoxFit.cover,
              ),
            Container(
              width: 350,
              child: AppText.heading4(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            if (subtitle != null)
              Column(
                children: <Widget>[
                  SizedBox(height: 14),
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
                  SizedBox(height: 16),
                  AppButton(
                    title: buttonTitle!,
                    action: () => buttonAction!(),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            Expanded(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

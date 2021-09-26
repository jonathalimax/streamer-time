import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardEventView extends StatelessWidget {
  final String game;
  final String title;
  final String day;
  final String month;
  final String weekday;
  final Color? color;
  final double? width;

  const CardEventView({
    Key? key,
    required this.game,
    required this.title,
    required this.day,
    required this.month,
    required this.weekday,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300,
      child: Card(
        color: color ?? kcLightPurple.withOpacity(.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: [
                      AppText(
                        day,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppText(
                        month.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppText(
                        weekday.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              AppText(
                game,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              AppText(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

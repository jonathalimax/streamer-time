import 'package:design_system/styles/app_colors.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 250.0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 25,
                    child: CircleAvatar(),
                  ),
                  SizedBox(width: 5),
                  AppText.heading4('Gaules'),
                ],
              ),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CardEventWidget(
                      day: '08',
                      month: 'out',
                      weekday: 'seg',
                      game: 'Counter-Strike: Global Offensive',
                      title: 'Furia vs NIP ESL Pro League S14',
                    ),
                    CardEventWidget(
                      day: '09',
                      month: 'out',
                      weekday: 'ter',
                      game: 'Counter-Strike: Global Offensive',
                      title: 'Furia vs Team Liquid ESL Pro League S14',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardEventWidget extends StatelessWidget {
  final String game;
  final String title;
  final String day;
  final String month;
  final String weekday;
  final Color? color;

  const CardEventWidget({
    Key? key,
    required this.game,
    required this.title,
    required this.day,
    required this.month,
    required this.weekday,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppText(
                        weekday.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              AppText(
                title,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

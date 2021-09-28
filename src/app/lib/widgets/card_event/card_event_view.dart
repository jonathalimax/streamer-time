import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardEventView extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final String? time;
  final Color? color;
  final double? width;

  const CardEventView({
    Key? key,
    required this.category,
    required this.title,
    required this.date,
    this.time,
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
                        date,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (time != null)
                        AppText(
                          time!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              AppText(
                category,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 2),
              AppText(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

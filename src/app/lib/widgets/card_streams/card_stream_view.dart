import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardStreamView extends StatelessWidget {
  final String game;
  final String username;
  final String totalViewers;

  const CardStreamView({
    Key? key,
    required this.game,
    required this.username,
    required this.totalViewers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText.body(
                      username,
                      color: kcIceWhite,
                    ),
                    AppText.caption(
                      game,
                      color: kcIceWhite,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 2),
                  AppText.caption(
                    totalViewers,
                    color: kcIceWhite,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

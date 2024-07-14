import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardGameTitleView extends StatelessWidget {
  final String game;
  final Function()? onTap;

  const CardGameTitleView({
    Key? key,
    required this.game,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: AppText.body(
                  game,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

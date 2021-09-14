import 'package:app/utils/extensions/number_extensions.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardStreamView extends StatelessWidget {
  final String game;
  final String username;
  final String totalViewers;
  final VoidCallback onTap;

  const CardStreamView({
    Key? key,
    required this.game,
    required this.username,
    required this.totalViewers,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: InkWell(
        onTap: onTap,
        highlightColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
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
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppText.body(
                        username,
                        color: kcIceWhite,
                      ),
                      AppText.caption(
                        game,
                        color: kcIceWhite,
                        maxLines: 1,
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
                    SizedBox(width: 4),
                    AppText.caption(
                      int.parse(totalViewers).thousandToK(),
                      color: kcIceWhite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

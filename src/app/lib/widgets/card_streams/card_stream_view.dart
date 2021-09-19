import 'package:app/utils/extensions/number_extensions.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardStreamView extends StatelessWidget {
  final String? game;
  final String username;
  final String totalViewers;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CardStreamView({
    Key? key,
    required this.username,
    required this.totalViewers,
    required this.onTap,
    this.game,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: InkWell(
        onTap: onTap,
        highlightColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        borderRadius: BorderRadius.all(Radius.circular(3)),
        child: Card(
          color: backgroundColor ?? Theme.of(context).primaryColor,
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
                      AppText.bodyBold(
                        username,
                        color: kcIceWhite,
                      ),
                      AppText.caption(
                        game ?? '',
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
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(width: 4),
                    AppText.captionBold(
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

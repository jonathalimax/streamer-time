import 'package:app/core/extensions/number_extensions.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardStreamView extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? totalViewers;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CardStreamView({
    Key? key,
    required this.title,
    required this.onTap,
    this.totalViewers,
    this.subtitle,
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
          color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                        title,
                        color: kcIceWhite,
                      ),
                      if (subtitle != null)
                        AppText.caption(
                          subtitle!,
                          color: kcIceWhite,
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
                totalViewers != null
                    ? Row(children: <Widget>[
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
                          int.parse(totalViewers!).thousandToK(),
                          color: kcIceWhite,
                        )
                      ])
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

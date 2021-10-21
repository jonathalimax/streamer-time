import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardGameView extends StatelessWidget {
  final String game;
  final String imageUrl;
  final Function()? onTap;

  const CardGameView({
    Key? key,
    required this.game,
    required this.imageUrl,
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
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: 200,
                  height: 300,
                  imageUrl: imageUrl,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => Center(
                    child: SpinKitDoubleBounce(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            AppText.body(
              game,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

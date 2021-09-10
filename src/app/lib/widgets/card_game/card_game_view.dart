import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardGameView extends StatelessWidget {
  final String game;
  final String imageUrl;

  const CardGameView({
    Key? key,
    required this.game,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              placeholder: (context, url) => Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).accentColor,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}

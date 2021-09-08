import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardGameWidget extends StatelessWidget {
  final String game;
  final String imageUrl;

  const CardGameWidget({
    Key? key,
    required this.game,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      child: Card(
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              width: 175,
              height: 300,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
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

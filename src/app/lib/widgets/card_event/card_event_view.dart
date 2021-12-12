import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardEventView extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final String? time;
  final Color? color;
  final double? width;
  final File? imageFile;
  final String? imageUrl;
  final Color? fontColor;
  final bool isLive;

  const CardEventView({
    Key? key,
    required this.category,
    required this.title,
    required this.date,
    this.time,
    this.color,
    this.width,
    this.imageFile,
    this.imageUrl,
    this.fontColor = kcIceWhite,
    this.isLive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 1.15,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        color: color ?? Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            if (imageFile != null)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.file(imageFile!).image,
                  ),
                ),
              ),
            if (imageUrl != null)
              CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SpinKitDoubleBounce(
                  size: 30,
                  color: kcIceWhite,
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (isLive) _buildLive(),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          children: [
                            AppText(
                              date,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: fontColor,
                              ),
                            ),
                            if (time != null) SizedBox(width: 3),
                            if (time != null)
                              AppText(
                                time!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: fontColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(.8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        category,
                        style: TextStyle(
                          fontSize: 17,
                          color: fontColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppText(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          color: fontColor,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLive() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: AppText(
          'AO VIVO',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}

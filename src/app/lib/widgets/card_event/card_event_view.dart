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
  final bool hasOverlay;

  const CardEventView({
    Key? key,
    required this.category,
    required this.title,
    required this.date,
    this.time,
    this.color,
    this.width = 300,
    this.imageFile,
    this.imageUrl,
    this.fontColor = Colors.white,
    this.hasOverlay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        color: color ?? kcLightPurple.withOpacity(.7),
        child: Stack(
          alignment: Alignment.center,
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
            Padding(
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
                            hasShadow: imageFile != null || imageUrl != null,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: imageFile != null || imageUrl != null
                                  ? fontColor
                                  : Colors.black,
                            ),
                          ),
                          if (time != null)
                            AppText(
                              time!,
                              hasShadow: imageFile != null || imageUrl != null,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: imageFile != null || imageUrl != null
                                    ? fontColor
                                    : Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  AppText(
                    category,
                    hasShadow: imageFile != null || imageUrl != null,
                    style: TextStyle(
                      fontSize: 16,
                      color: imageFile != null || imageUrl != null
                          ? fontColor
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  AppText(
                    title,
                    hasShadow: imageFile != null || imageUrl != null,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: imageFile != null || imageUrl != null
                          ? fontColor
                          : Colors.black,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

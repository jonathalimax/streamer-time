import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardEventView extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final String? time;
  final Color? color;
  final double? width;
  final File? backgroundImage;
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
    this.backgroundImage,
    this.fontColor,
    this.hasOverlay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        color: color ?? kcLightPurple.withOpacity(.7),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (backgroundImage != null)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                      hasOverlay
                          ? Colors.black.withOpacity(.7)
                          : Colors.black.withOpacity(1),
                      BlendMode.dstATop,
                    ),
                    fit: BoxFit.fill,
                    image: Image.file(
                      backgroundImage!,
                      isAntiAlias: true,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, _, stackTrack) => Container(),
                    ).image,
                  ),
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
                            hasShadow: backgroundImage != null,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: backgroundImage == null
                                  ? Colors.black
                                  : fontColor,
                            ),
                          ),
                          if (time != null)
                            AppText(
                              time!,
                              hasShadow: backgroundImage != null,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: backgroundImage == null
                                    ? Colors.black
                                    : fontColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  AppText(
                    category,
                    hasShadow: backgroundImage != null,
                    style: TextStyle(
                      fontSize: 16,
                      color: backgroundImage == null ? Colors.black : fontColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  AppText(
                    title,
                    hasShadow: backgroundImage != null,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: backgroundImage == null ? Colors.black : fontColor,
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

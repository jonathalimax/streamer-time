import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileImageView extends StatelessWidget {
  final BuildContext context;
  final String imageUrl;
  final double? size;

  double get radius => size != null ? size! / 2 : 25;

  const ProfileImageView({
    Key? key,
    required this.context,
    required this.imageUrl,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: size ?? 50,
      width: size ?? 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
          width: 2.0,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
              child: SpinKitDoubleBounce(
                size: 30,
                color: kcIceWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

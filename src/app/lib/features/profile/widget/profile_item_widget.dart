import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Widget? leading;

  const ProfileItemWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(.2),
      child: ListTile(
        title: leading != null
            ? Align(
                alignment: Alignment(-1.2, 0),
                child: AppText.heading4(title),
              )
            : AppText.heading4(title),
        leading: leading,
      ),
    );
  }
}

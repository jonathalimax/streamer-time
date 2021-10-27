import 'package:app/network/models/event.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:app/widgets/profile_image_view.dart';
import 'package:design_system/styles/app_colors.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AgendaView extends StatelessWidget {
  final String title;
  final String? profileImageUrl;
  final List<Event> events;
  final Function()? onStreamerTap;
  final Function()? onEventTap;

  const AgendaView({
    Key? key,
    required this.title,
    required this.events,
    this.profileImageUrl,
    this.onStreamerTap,
    this.onEventTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onStreamerTap,
            highlightColor:
                Theme.of(context).colorScheme.secondary.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(3)),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: <Widget>[
                  if (profileImageUrl != null)
                    ProfileImageView(
                      context: context,
                      imageUrl: profileImageUrl!,
                      size: 40,
                    ),
                  SizedBox(width: 10),
                  AppText.heading4(title),
                ],
              ),
            ),
          ),
          SizedBox(height: 2),
          Flexible(
            child: ListView.builder(
              itemCount: events.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: onEventTap,
                  highlightColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  child: CardEventView(
                    date: events[index].dateDisplay,
                    time: events[index].timeDisplay,
                    category: events[index].categoryName,
                    title: events[index].title,
                    imageUrl: events[index].imageUrl,
                    fontColor: kcIceWhite,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}

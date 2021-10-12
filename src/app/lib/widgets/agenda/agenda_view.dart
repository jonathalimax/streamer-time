import 'package:app/network/models/event.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:app/widgets/profile_image_view.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AgendaView extends StatelessWidget {
  final String title;
  final String? profileImageUrl;
  final List<Event> events;

  const AgendaView({
    Key? key,
    required this.title,
    required this.events,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: Column(
        children: <Widget>[
          Row(
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
          SizedBox(height: 6),
          Flexible(
            child: ListView.builder(
              itemCount: events.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardEventView(
                  date: events[index].dateDisplay,
                  time: events[index].timeDisplay,
                  category: events[index].categoryName,
                  title: events[index].title,
                  imageUrl: events[index].imageUrl,
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

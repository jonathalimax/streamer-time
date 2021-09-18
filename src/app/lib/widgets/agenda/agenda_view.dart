import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AgendaView extends StatelessWidget {
  final String title;
  final Image? profile;

  const AgendaView({
    Key? key,
    required this.title,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (profile != null)
                Container(
                  width: 25,
                  child: CircleAvatar(),
                ),
              SizedBox(width: 5),
              AppText.heading4(title),
            ],
          ),
          SizedBox(height: 4),
          Flexible(
            child: ListView(
              key: PageStorageKey('GaulesAgendaKey'),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                CardEventView(
                  day: '08',
                  month: 'out',
                  weekday: 'seg',
                  game: 'Counter-Strike: Global Offensive',
                  title: 'Furia vs NIP ESL Pro League S14',
                ),
                CardEventView(
                  day: '09',
                  month: 'out',
                  weekday: 'ter',
                  game: 'Counter-Strike: Global Offensive',
                  title: 'Furia vs Team Liquid ESL Pro League S14',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

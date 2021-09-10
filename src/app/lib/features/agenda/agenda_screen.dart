import 'package:app/app/app.locator.dart';
import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgendaViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<AgendaViewModel>(),
      builder: (context, viewModel, child) => _buildScreen(context),
    );
  }

  Scaffold _buildScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 250.0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 25,
                    child: CircleAvatar(),
                  ),
                  SizedBox(width: 5),
                  AppText.heading4('Gaules'),
                ],
              ),
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
        ),
      ),
    );
  }
}

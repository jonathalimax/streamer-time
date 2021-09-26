import 'package:app/features/event/event_time/create_event_time_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateEventTimeScreen extends StatelessWidget {
  const CreateEventTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventTimeViewModel>.reactive(
      viewModelBuilder: () => CreateEventTimeViewModel(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Novo evento',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(flex: 2),
                Container(
                  height: 200,
                  child: CardEventView(
                    game: 'Categoria',
                    title: 'Título do evento',
                    day: '26 OCT',
                    month: '02:30 AM',
                    weekday: '',
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 20),
                AppText.heading4('Pré-visualização'),
                Spacer(flex: 5),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: 'Definir horário',
                    action: () => viewModel.selectTime(context),
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: 'Continuar',
                    action: () {},
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

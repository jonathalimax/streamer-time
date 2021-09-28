import 'package:app/features/event/event_date/create_event_date_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:design_system/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateEventDateTimeScreen extends StatelessWidget {
  const CreateEventDateTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventDateViewModel>.reactive(
      viewModelBuilder: () => CreateEventDateViewModel(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Novo evento',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 30),
                AppText.heading4('Pré-visualização'),
                SizedBox(height: 12),
                Container(
                  height: 200,
                  child: CardEventView(
                    category: 'Categoria',
                    title: 'Título do evento',
                    date: viewModel.selectedDateFormated,
                    time: viewModel.selectedTimeFormated,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: 'Definir data',
                    action: () => viewModel.selectDate(context),
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: 'Definir horário',
                    action: () => viewModel.selectTime(context),
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                Spacer(flex: 5),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: 'Continuar',
                    action: () => viewModel.startEventTimeScreen(),
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

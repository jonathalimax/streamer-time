import 'package:app/features/event/widget/event_step_one_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'create_event_step_one_viewmodel.dart';

class CreateEventStepOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventStepOneViewModel>.reactive(
      viewModelBuilder: () => CreateEventStepOneViewModel(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Novo evento',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: viewModel.isBusy
            ? Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : EventStepOneWidget(
                callToActionTitle: 'Continuar',
                callToAction: (title, category) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  viewModel.continueCreatingEvent(context, title, category);
                },
              ),
      ),
    );
  }
}

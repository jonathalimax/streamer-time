import 'package:app/features/event/widget/event_step_two_widget.dart';
import 'package:app/features/event/widget/event_step_two_widget_viewmodel.dart';

import 'create_event_step_two_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class CreateEventStepTwoScreen extends StatelessWidget {
  final CreateEventStepTwoViewModel viewModel;

  const CreateEventStepTwoScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventStepTwoViewModel>.reactive(
      viewModelBuilder: () => viewModel,
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
            : EventStepTwoWidget(
                viewModel: EventStepTwoWidgetViewModel(
                  null,
                  viewModel.title,
                  viewModel.category,
                ),
                callToActionTitle: 'Continuar',
                callToAction: (image, date) {
                  viewModel.createEvent(context, image, date);
                },
              ),
      ),
    );
  }
}

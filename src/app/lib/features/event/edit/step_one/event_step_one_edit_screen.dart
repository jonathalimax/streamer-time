import 'package:app/features/event/widget/event_step_one_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'event_step_one_edit_viewmodel.dart';

class EventStepOneEditScreen extends StatelessWidget {
  final EventStepOneEditViewModel viewModel;

  const EventStepOneEditScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventStepOneEditViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Editar evento',
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
                  title: viewModel.event.title,
                  category: viewModel.event.category,
                  date: viewModel.event.dateDisplay,
                  time: viewModel.event.timeDisplay,
                  imageUrl: viewModel.event.imageUrl,
                  callToActionTitle: 'Continuar editando',
                  callToAction: viewModel.continueEditingEvent,
                ),
        );
      },
    );
  }
}

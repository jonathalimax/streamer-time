import 'package:app/features/event/edit/step_two/event_step_two_edit_viewmodel.dart';
import 'package:app/features/event/widget/event_step_two_widget.dart';
import 'package:app/features/event/widget/event_step_two_widget_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class EventStepTwoEditScreen extends StatelessWidget {
  final EventStepTwoEditViewModel viewModel;
  const EventStepTwoEditScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventStepTwoEditViewModel>.reactive(
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
              : EventStepTwoWidget(
                  viewModel: EventStepTwoWidgetViewModel(
                    viewModel.event,
                    viewModel.event.title,
                    viewModel.category,
                  ),
                  callToActionTitle: 'Salvar alterações',
                  callToAction: (image, date, duration) {
                    viewModel.saveEvent(context, image, date, duration);
                  },
                ),
        );
      },
    );
  }
}

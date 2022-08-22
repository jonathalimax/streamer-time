import 'dart:io';

import 'package:app/features/event/widget/event_step_two_widget_viewmodel.dart';
import 'package:app/widgets/card_event/card_event_view.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EventStepTwoWidget extends StatelessWidget {
  final EventStepTwoWidgetViewModel viewModel;
  final String callToActionTitle;
  final Function(File? image, DateTime date) callToAction;

  const EventStepTwoWidget({
    Key? key,
    required this.viewModel,
    required this.callToActionTitle,
    required this.callToAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventStepTwoWidgetViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, viewModel, child) {
        return SafeArea(
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
                SizedBox(height: 4),
                Container(
                  height: 230,
                  child: CardEventView(
                    title: viewModel.title,
                    category: viewModel.category.name,
                    date: viewModel.selectedDateFormated,
                    time: viewModel.selectedTimeFormated,
                    width: double.infinity,
                    imageFile: viewModel.selectedImage,
                    imageUrl: viewModel.event?.imageUrl,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title:
                        '${viewModel.event == null ? 'Adicionar' : 'Atualizar'} data e hora',
                    action: () => viewModel.setDateTime(context),
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title:
                        '${viewModel.event == null ? 'Adicionar' : 'Atualizar'} imagem de fundo',
                    action: () => viewModel.showImageSourceActionSheet(context),
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                Spacer(flex: 5),
                SizedBox(
                  width: 290,
                  child: AppButton(
                    title: callToActionTitle,
                    action: () {
                      callToAction(
                        viewModel.selectedImage,
                        viewModel.selectedDate,
                      );
                    },
                    color: Colors.transparent,
                    titleColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

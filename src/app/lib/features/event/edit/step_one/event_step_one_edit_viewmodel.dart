import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/event/edit/step_two/event_step_two_edit_viewmodel.dart';
import 'package:app/network/models/event.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class EventStepOneEditViewModel extends BaseViewModel {
  final Event event;
  final _navigationService = locator<NavigationService>();

  EventStepOneEditViewModel(this.event);

  void continueEditingEvent(
    BuildContext context,
    String? title,
    TwitchGame? category,
  ) {
    if (title == null || category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText.captionBold(
            'A categoria e título são obrigatórios!',
          ),
        ),
      );
      return;
    }

    event.title = title;
    event.categoryId = category.id;
    event.categoryName = category.name;

    _navigationService.navigateTo(
      Routes.eventStepTwoEditScreen,
      arguments: EventStepTwoEditScreenArguments(
        viewModel: EventStepTwoEditViewModel(event, category),
      ),
    );
  }
}

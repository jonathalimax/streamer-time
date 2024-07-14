import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/event/create/event_step_two/create_event_step_two_viewmodel.dart';
import 'package:design_system/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventStepOneViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void continueCreatingEvent(
    BuildContext context,
    String? title,
    TwitchGame? category,
  ) {
    final hasTitle = title != null && title.isNotEmpty;

    if (category == null || !hasTitle) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText.captionBold(
            category == null
                ? 'Selecione uma categoria válida!'
                : 'Esqueceu do título da live?',
          ),
        ),
      );
      return;
    }

    _navigationService.navigateTo(
      Routes.createEventStepTwoScreen,
      arguments: CreateEventStepTwoScreenArguments(
        viewModel: CreateEventStepTwoViewModel(
          title,
          category,
        ),
      ),
    );
  }
}

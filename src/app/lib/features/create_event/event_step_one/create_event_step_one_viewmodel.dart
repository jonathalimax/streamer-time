import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/create_event/event_step_two/create_event_step_two_viewmodel.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventStepOneViewModel extends BaseViewModel {
  final _twitchService = locator<TwitchService>();
  final _navigationService = locator<NavigationService>();

  String? selectedTitle;
  TwitchGame? selectedCategory;

  Future<List<TwitchGame>> getCategorySuggestion(String query) async {
    TwitchResponse<TwitchGame> response;

    response = query.isEmpty
        ? await _twitchService.client.getTopGames()
        : await _twitchService.client.searchCategories(query: query);

    if (response.data == null) [];
    return response.data!
        .where(
          (game) => game.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> setCategory(TwitchGame category) async {
    this.selectedCategory = category;
    notifyListeners();
  }

  void setTitle(String title) {
    this.selectedTitle = title;
    notifyListeners();
  }

  Future<void> continueCreatingEvent() async {
    if (selectedTitle == null || selectedCategory == null) return;
    final viewModel =
        CreateEventStepTwoViewModel(selectedTitle!, selectedCategory!);
    return await _navigationService.navigateTo(
      Routes.createEventStepTwoScreen,
      arguments: CreateEventStepTwoScreenArguments(viewModel: viewModel),
    );
  }
}

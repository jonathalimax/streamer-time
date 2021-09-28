import 'package:app/app/app.locator.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventTitleViewModel extends BaseViewModel {
  final _twitchService = locator<TwitchService>();

  String? selectedTitle;
  TwitchGame? selectedCategory;

  final String selectedDateFormated;
  final String selectedTimeFormated;

  CreateEventTitleViewModel(
    this.selectedDateFormated,
    this.selectedTimeFormated,
  );

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

  setTitle(String title) {
    this.selectedTitle = title;
    notifyListeners();
  }
}

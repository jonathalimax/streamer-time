import 'package:app/app/app.locator.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

class EventStepOneWidgetViewModel extends BaseViewModel {
  final _twitchService = locator<TwitchService>();
  TwitchResponse<TwitchGame>? topCategories;

  String? selectedTitle;
  TwitchGame? selectedCategory;

  Future<List<TwitchGame>> getCategorySuggestion(String query) async {
    TwitchResponse<TwitchGame> response;

    if (query.isNotEmpty) {
      response = await _twitchService.client.searchCategories(query: query);
    } else if (topCategories != null) {
      response = topCategories!;
    } else {
      response = await _twitchService.client.getTopGames();
      topCategories = response;
    }

    if (response.data == null) [];
    return response.data!
        .where(
          (game) => game.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> setCategory(TwitchGame? category) async {
    this.selectedCategory = category;
    notifyListeners();
  }

  void setTitle(String title) {
    this.selectedTitle = title;
    notifyListeners();
  }
}

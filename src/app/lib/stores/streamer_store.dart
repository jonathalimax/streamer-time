import 'package:mobx/mobx.dart';

import '../network/models/user.dart';
part 'streamer_store.g.dart';

class StreamerStore = _StreamerStore with _$StreamerStore;

abstract class _StreamerStore with Store {
  @observable
  var streamers = ObservableList<User>();

  bool get hasUpcomingEvents {
    return streamers.any((element) => element.upcoming.isNotEmpty);
  }

  @action
  void add(User streamer) {
    streamers.add(streamer);
  }

  @action
  void set(List<User> allStreamers) {
    streamers.clear();
    allStreamers.forEach(streamers.add);
  }

  @action
  void removeById(String streamerId) {
    final filteredStreamers =
        streamers.firstWhere((element) => element.id == streamerId);
    streamers.remove(filteredStreamers);
  }
}

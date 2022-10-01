import 'package:mobx/mobx.dart';

import '../network/models/user.dart';
part 'streamer_store.g.dart';

class StreamerStore = _StreamerStore with _$StreamerStore;

abstract class _StreamerStore with Store {
  @observable
  var streamers = ObservableList<User>();

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
        streamers.where((element) => element.id == streamerId).toList();
    if (filteredStreamers.isEmpty) return;
    streamers.remove(filteredStreamers.first);
  }
}

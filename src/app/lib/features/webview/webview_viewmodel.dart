import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class WebviewViewModel extends BaseViewModel {
  void startLoader() {
    setBusy(true);
    notifyListeners();
  }

  void finishLoader() {
    setBusy(false);
    notifyListeners();
  }
}

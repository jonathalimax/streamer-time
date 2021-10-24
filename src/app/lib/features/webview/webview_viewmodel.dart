import 'package:stacked/stacked.dart';

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

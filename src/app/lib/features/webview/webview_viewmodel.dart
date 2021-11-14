import 'package:stacked/stacked.dart';

class WebviewViewModel extends BaseViewModel {
  void startLoader() {
    setBusy(true);
  }

  void finishLoader() {
    setBusy(false);
  }
}

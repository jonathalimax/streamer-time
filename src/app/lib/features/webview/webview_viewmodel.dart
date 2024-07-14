import 'package:stacked/stacked.dart';

class WebviewViewModel extends BaseViewModel {
  bool isLoading = true;

  setLoding(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}

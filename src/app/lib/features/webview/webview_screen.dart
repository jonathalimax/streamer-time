import 'package:app/app/app.locator.dart';
import 'package:app/features/webview/webview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef ShouldNavigateCallback = Future<bool> Function(String url);

class WebViewScreen extends StatelessWidget {
  final String url;
  final ShouldNavigateCallback shouldNavigate;

  WebViewScreen(
    this.url,
    this.shouldNavigate,
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebviewViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<WebviewViewModel>(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(),
        body: LoadingOverlay(
          color: Theme.of(context).scaffoldBackgroundColor,
          isLoading: viewModel.isBusy,
          progressIndicator: SpinKitDoubleBounce(
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            zoomEnabled: false,
            gestureNavigationEnabled: true,
            onProgress: (value) => value != 100
                ? viewModel.setBusy(true)
                : viewModel.setBusy(false),
            navigationDelegate: (NavigationRequest request) async {
              return await shouldNavigate(request.url)
                  ? NavigationDecision.navigate
                  : NavigationDecision.prevent;
            },
            onWebViewCreated: (controller) {
              controller.clearCache();
            },
          ),
        ),
      ),
    );
  }
}

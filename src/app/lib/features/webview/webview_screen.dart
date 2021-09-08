import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
      ),
      url: url,
      initialChild: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).accentColor,
        ),
      ),
      withZoom: false,
      displayZoomControls: false,
      appCacheEnabled: false,
      clearCache: true,
      clearCookies: true,
    );
  }
}

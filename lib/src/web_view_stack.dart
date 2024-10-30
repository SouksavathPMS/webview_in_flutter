import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key});

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadinPercentage = 0;
  late final WebViewController _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadinPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadinPercentage = progress;
            });
          },
          onPageFinished: (url) {},
        ),
      )
      ..loadRequest(Uri.parse("https://flutter.dev"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _webViewController),
        if (loadinPercentage < 100)
          LinearProgressIndicator(
            value: loadinPercentage / 100.0,
          ),
      ],
    );
  }
}

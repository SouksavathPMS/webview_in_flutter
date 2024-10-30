import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadinPercentage = 0;

  @override
  void initState() {
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => loadinPercentage = 0),
          onProgress: (progress) => setState(() => loadinPercentage = progress),
          onPageFinished: (url) => setState(() => loadinPercentage = 100),
          onNavigationRequest: (request) {
            final host = Uri.parse(request.url).host;
            if (host.contains("youtube.com")) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Blocking navigation to $host"),
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "SnackBar",
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message.message),
            ),
          );
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: widget.controller),
        if (loadinPercentage < 100)
          LinearProgressIndicator(
            value: loadinPercentage / 100.0,
          ),
      ],
    );
  }
}

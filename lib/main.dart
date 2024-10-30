import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_in_flutter/src/menu.dart';
import 'package:webview_in_flutter/src/navigation_controls.dart';
import 'package:webview_in_flutter/src/web_view_stack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview in flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late WebViewController _webViewController;
  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(
        Uri.parse("https://flutter.dev"),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Webview"),
        centerTitle: false,
        actions: [
          NavigationControls(controller: _webViewController),
          Menu(controller: _webViewController),
        ],
      ),
      body: WebViewStack(controller: _webViewController),
    );
  }
}

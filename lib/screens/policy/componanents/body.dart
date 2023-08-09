import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final WebViewController _controller;
  bool isLoading = true;
  var loadingPercentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          print('Page started loading: $url');
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          print('Loading progress: $progress');
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          print('Page finished loading: $url');
          setState(() {
            loadingPercentage = 100;
          });
        },
        onNavigationRequest: (navigation) {
          final host = Uri.parse(navigation.url).host;
          if (host.contains('http://www.seafresh.com/th/job/')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Blocking navigation to $host',
                ),
              ),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse('http://seafresh.com/th/privacy-notice'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (loadingPercentage < 100)
          LinearProgressIndicator(value: loadingPercentage / 100),
        loadingPercentage < 100
            ? const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ))
            : Stack(),
        /* isLoading ? Center(child: CircularProgressIndicator(),):
              Stack(),*/
      ],
    );
  }
}

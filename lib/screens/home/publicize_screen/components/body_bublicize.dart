import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyBublicize extends StatefulWidget {
  final String publicizeID;
  const BodyBublicize({Key? key,required this.publicizeID }) : super(key: key);

  @override
  State<BodyBublicize> createState() => _BodyBublicizeState();
}

class _BodyBublicizeState extends State<BodyBublicize> {
  late final WebViewController _controller;
  bool isLoading=true;
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
          if (host.contains('http://61.7.142.47:8086/sfiblog/Publicize.php?id=${widget.publicizeID}')) {
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
      ..loadRequest(Uri.parse('http://61.7.142.47:8086/sfiblog/Publicize.php?id=${widget.publicizeID}'))
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
    return Container(
      child: Center(
        child: Stack(
          children: [
            WebViewWidget(
                controller: _controller),
            if (loadingPercentage < 100)
              LinearProgressIndicator(value: loadingPercentage / 100),
            loadingPercentage < 100
                ? const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                )
            )
                : Stack(),
            /* isLoading ? Center(child: CircularProgressIndicator(),):
              Stack(),*/
          ],
        ),
      )
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML 
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter 
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class JobEntryScreen extends StatefulWidget {

  const JobEntryScreen({Key? key}) : super(key: key);

  static String routName = "/jobEntry_screen";

  @override
  State<JobEntryScreen> createState() => _JobEntryState();
}

class _JobEntryState extends State<JobEntryScreen> {
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
      ..loadRequest(Uri.parse('http://www.seafresh.com/th/job/'))
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
    return Scaffold(
      appBar: CustomAppBarMenu("ตำแหน่งงานว่าง"),
      body:  Stack(
        children: [
         WebViewWidget(controller: _controller),
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
      )

    );

  }

}



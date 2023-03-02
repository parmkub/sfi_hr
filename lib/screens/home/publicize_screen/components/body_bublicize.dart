import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyBublicize extends StatefulWidget {
  final String publicizeID;
  final String WebViewType;
  final String publicizeDetail;
  const BodyBublicize(
      {Key? key,
      required this.publicizeID,
      required this.WebViewType,
      required this.publicizeDetail})
      : super(key: key);

  @override
  State<BodyBublicize> createState() => _BodyBublicizeState();
}

class _BodyBublicizeState extends State<BodyBublicize> {
  String WebViewType = '';
  String publicizeDetail = '';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late final WebViewController _controller;
  bool isLoading = true;
  var loadingPercentage = 0;

  @override
  void initState() {
    WebViewType = widget.WebViewType;
    publicizeDetail = widget.publicizeDetail;

    if (WebViewType == 'webview') {
      OnloadPage();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (WebViewType == 'webview') {
      return WebView();
    } else if (WebViewType == 'pdf') {
      return PDFView();
    } else {
      return Container(
        decoration: const BoxDecoration(
          gradient: kBackgroundColor
        ),

      );
    }
  }

  SfPdfViewer PDFView() {
    return SfPdfViewer.network(
      publicizeDetail,
      key: _pdfViewerKey,
    );
  }

  Container WebView() {
    return Container(
        child: Center(
      child: Stack(
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
      ),
    ));
  }

  void OnloadPage() {
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
            _pdfViewerKey.currentState?.openBookmarkView();
          });
        },
        onNavigationRequest: (navigation) {
          final host = Uri.parse(navigation.url).host;
          if (host.contains(
              'http://61.7.142.47:8086/sfiblog/Publicize.php?id=${widget.publicizeID}')) {
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
      ..loadRequest(Uri.parse(
          'http://61.7.142.47:8086/sfiblog/Publicize.php?id=${widget.publicizeID}'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }
}

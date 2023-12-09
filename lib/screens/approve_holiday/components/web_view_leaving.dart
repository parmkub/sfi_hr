import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app_localizations.dart';

class WebViewLeaving extends StatefulWidget {
  final String documentId;

  final String typeLeave;
  const WebViewLeaving({super.key, required this.documentId, required this.typeLeave});

  @override
  State<WebViewLeaving> createState() => _WebViewLeavingState();
}

class _WebViewLeavingState extends State<WebViewLeaving> {
  @override

  @override
  Widget build(BuildContext context) {
    String documentId = widget.documentId;
    String typeLeave = widget.typeLeave;
    print('documentId :==> $documentId');
    String uri = "http://61.7.142.47:8086/sfi-hr/reportLaSick.php?documentNo=$documentId&typeLeave=$typeLeave";
    print('uri :==> $uri');
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

        ),
      )
      ..loadRequest(Uri.parse('$uri'));

    return Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context).translate('detail')),
        ),
        body: WebViewWidget(controller: controller)
    );

  }
}


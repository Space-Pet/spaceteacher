import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/utils.dart';

part 'webview.action.dart';

class WebViewArgs {
  final String? url;
  final String? html;
  final String? title;

  WebViewArgs({this.url, this.html, this.title});
}

class WebViewScreen extends StatefulWidget {
  final WebViewArgs? params;

  const WebViewScreen({
    Key? key,
    this.params,
  }) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _controller = WebViewController();

  @override
  void initState() {
    // themeColor.setLightStatusBar();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadHtmlString();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant WebViewScreen oldWidget) {
    if (oldWidget.params?.url != widget.params?.url ||
        oldWidget.params?.html != widget.params?.html) {
      loadHtmlString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

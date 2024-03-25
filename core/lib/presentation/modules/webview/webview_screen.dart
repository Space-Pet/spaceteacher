import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/utils.dart';
import '../../common_widget/export.dart';
import '../../theme/theme_color.dart';

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
    themeColor.setLightStatusBar();
          _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant WebViewScreen oldWidget) {
    if (oldWidget.params?.url != widget.params?.url ||
        oldWidget.params?.html != widget.params?.html) {
      loadData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenForm(
      showHeaderImage: false,
      headerColor: themeColor.primaryColor,
      title: widget.params?.title,
      child: Container(
        color: themeColor.colorF0F0F5,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

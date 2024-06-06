import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);
  double _progress = 0;
  String _url = '';

  @override
  void dispose() {
    // TODO: implement dispose
    webViewController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (webViewController != null) {
          webViewController!.reload();
        }
      },
    );

    _url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Column(
          children: [
            const ScreenAppBar(
              title: 'Thanh toán',
              canGoback: false,
            ),
            Expanded(
              child: Container(
                color: AppColors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialSettings: settings,
                      initialUrlRequest: URLRequest(
                        url: WebUri.uri(
                          Uri.parse(_url),
                        ),
                      ),
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        _url = url.toString();
                        setState(() {});
                      },
                      onLoadStop: (controller, url) async {
                        _url = url.toString();
                        setState(() {});
                        await pullToRefreshController.endRefreshing();
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        final uri = navigationAction.request.url!;
                        if (uri.scheme == 'myapp') {
                          // Handle custom scheme
                          print('Custom scheme detected: $uri');
                          return NavigationActionPolicy.CANCEL;
                        }
                        return NavigationActionPolicy.ALLOW;
                      },
                      onProgressChanged: (controller, progress) {
                        setState(() {
                          _progress = progress / 100;
                        });
                      },
                    ),
                    if (_progress < 1)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: LinearProgressIndicator(
                            value: _progress,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.brand600),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: AppColors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  webViewController?.goBack();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {
                                  webViewController?.reload();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  webViewController?.goForward();
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.close)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

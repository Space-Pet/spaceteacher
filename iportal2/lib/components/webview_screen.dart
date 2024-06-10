import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController pullToRefreshController = PullToRefreshController();

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);
  double _progress = 0;
  String _url = '';
  String _statusPayment = '';
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
                        // Register event closeButtonClicked
                        _registerEventCloseBtn(controller, context);
                        webViewController = controller;
                      },
                      // handle message content when submit payment
                      onLoadStop: (controller, url) async {
                        setState(() {});
                        await pullToRefreshController.endRefreshing();
                        String res = await controller.evaluateJavascript(
                            source: """document.body.innerText""");
                        Log.d('res payment: $res');
                        await _handleBtnCloseAfterPayment(controller);
                      },

                      // handle console message when submit payment
                      onConsoleMessage: (controller, consoleMessage) {
                        // Log.d(consoleMessage.message);
                        if (consoleMessage.message.contains("SUCCESS")) {
                          Log.d('Thanh toán thành công');
                          _statusPayment = PaymentStatusResult.success.value;
                        } else if (consoleMessage.message.contains("FAILED")) {
                          Log.d('Thanh toán thất bại');
                          _statusPayment = PaymentStatusResult.failed.value;
                        }
                      },

                      // handle loading progress
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
                                    if (_statusPayment ==
                                        PaymentStatusResult.success.value) {
                                      context.pop(true);
                                    } else {
                                      context.pop(false);
                                    }
                                    setState(() {});
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

  void _registerEventCloseBtn(
      InAppWebViewController controller, BuildContext context) {
    return controller.addJavaScriptHandler(
        handlerName: 'closeButtonClicked',
        callback: (args) {
          if (_statusPayment == PaymentStatusResult.success.value) {
            context.pop(true);
          } else {
            context.pop(false);
          }
        });
  }

  Future<dynamic> _handleBtnCloseAfterPayment(
      InAppWebViewController controller) {
    return controller.evaluateJavascript(source: """
            (function() {
              var button = document.getElementsByClassName('btn btn-danger')[0];
              if (button && button.innerText === 'Đóng') {
                button.addEventListener('click', function() {
                  window.flutter_inappwebview.callHandler('closeButtonClicked');
                });
                return true;
              }
              return false;
            })();
          """);
  }
}

enum PaymentStatusResult { success, failed }

extension PaymentStatusX on PaymentStatusResult {
  String get value {
    switch (this) {
      case PaymentStatusResult.success:
        return 'SUCCESS';
      case PaymentStatusResult.failed:
        return 'FAILED';
      default:
        return '';
    }
  }
}

part of 'webview_screen.dart';

extension WebviewAction on _WebViewScreenState {
  String? get url {
    if (widget.params?.url?.isNotEmpty != true) {
      return null;
    }
    if (widget.params?.url?.startsWith('http://') == false &&
        widget.params?.url?.startsWith('https://') == false) {
      return 'http://$url';
    } else {
      return widget.params?.url;
    }
  }

  Uri? get uri => Uri.tryParse(url ?? '');

  void loadData() {
    if (url == null) {
      _controller.loadRequest(
        Uri.dataFromString(
          CommonFunction.wrapStyleHtmlContent(widget.params?.html ?? ''),
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ),
      );
    }
  }
  
  void loadHtmlString() {
    _controller.loadHtmlString(widget.params?.html ?? '');
  }
}

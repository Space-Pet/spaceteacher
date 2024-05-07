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
  
  void loadHtmlString() {
    _controller.loadHtmlString(widget.params?.html ?? '');
  }
}

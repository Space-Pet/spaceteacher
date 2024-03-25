import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import '../../../common/constants.dart';
import '../../../common/utils/log_utils.dart';

class LegacyDeeplink {
  static final LegacyDeeplink _instance = LegacyDeeplink._internal();

  factory LegacyDeeplink() {
    return _instance;
  }
  LegacyDeeplink._();

  LegacyDeeplink._internal();

  bool _initialUriIsHandled = false;
  StreamSubscription? _subscription;
  static final shared = LegacyDeeplink._();

  static final deeplinkController = StreamController<String>.broadcast();

  Stream<String> get onReceiveStreamDeepLink {
    return deeplinkController.stream;
  }

  void handleIncomingLinks() {
    if (!kIsWeb) {
      if (_subscription != null) {
        return;
      } // avoid adding existed sub
      _subscription = uriLinkStream.listen(
        (Uri? uri) {
          LogUtils.d('LegacyDeeplink got uri: $uri');

          if (uri.toString().startsWith('vnpay')) {
            deeplinkController.add(PaymentMethodType.vnpay);
          }

          if (uri.toString().startsWith('momo')) {
            deeplinkController.add(PaymentMethodType.momo);
          }
        },
        onError: (Object err) {
          LogUtils.e('LegacyDeeplink got err: $err');
        },
      );
    }
  }

  Future<void> handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        LogUtils.d('LegacyDeeplink initial uri: $uri');
      } on PlatformException {
        LogUtils.e('LegacyDeeplink falied to get initial uri');
      } on FormatException {
        LogUtils.e('LegacyDeeplink falied to get initial uri');
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}

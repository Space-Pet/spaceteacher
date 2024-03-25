part of '../constants.dart';

class MessageKeyConstant {
  static const String type = 'type';
  static const String status = 'status';
  static const String buttonFunctions = 'buttonFunctions';
  static const String title = 'title';
  static const String content = 'content';
}

class MessageTypeConstant {
  static const String text = 'text';
  static const String actionWithStatus = 'actionWithStatus';
  static const String actionWithButtons = 'actionWithButtons';
  static const String image = 'image';
  static const String resendDate = 'resendDate';
  static const String resendPrice = 'resendPrice';
}

class MessageStatusConstant {
  static const String waiting = 'chat.waiting';
  static const String accepted = 'chat.accepted';
  static const String denied = 'chat.denied';
}

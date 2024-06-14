part of 'noti_create_bloc.dart';

sealed class NotiCreateEvent {}

class NotiCreateSelectRecipient extends NotiCreateEvent {
  NotiCreateSelectRecipient({required this.recipient});

  final NotificationRecipient recipient;
}

class NotiCreateFetchListClass extends NotiCreateEvent {
  NotiCreateFetchListClass();
}

class NotiCreateSelectClass extends NotiCreateEvent {
  NotiCreateSelectClass({required this.className});

  final String className;
}

class NotiCreateFetchListPupil extends NotiCreateEvent {
  NotiCreateFetchListPupil();
}

class NotiCreateSelectPupil extends NotiCreateEvent {
  NotiCreateSelectPupil({required this.listId});

  final List<int> listId;
}

class NotiCreateSelectImages extends NotiCreateEvent {
  NotiCreateSelectImages({required this.listImg});

  final List<File> listImg;
}

class NotiRemovetImage extends NotiCreateEvent {
  NotiRemovetImage({required this.index});

  final int index;
}

class NotiCreateNewNoti extends NotiCreateEvent {
  final String title;
  final String content;

  NotiCreateNewNoti({required this.title, required this.content});
}

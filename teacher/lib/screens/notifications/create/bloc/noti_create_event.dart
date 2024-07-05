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
  NotiCreateSelectClass({
    required this.className,
    this.isFetchClassOnly = false,
  });

  final String className;
  final bool isFetchClassOnly;
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

class NotiCreateSelectFiles extends NotiCreateEvent {
  NotiCreateSelectFiles({required this.listFile});

  final List<UploadFile> listFile;
}

class NotiRemovetImage extends NotiCreateEvent {
  NotiRemovetImage({required this.index});

  final int index;
}

class NotiRemoveFile extends NotiCreateEvent {
  NotiRemoveFile({required this.index});

  final int index;
}

class NotiCreateNewNoti extends NotiCreateEvent {
  final String title;
  final String content;
  final String status;

  NotiCreateNewNoti({
    required this.title,
    required this.content,
    this.status = 'active',
  });
}

class NotiUpdate extends NotiCreateEvent {
  final String title;
  final String content;
  final String status;
  final int id;

  NotiUpdate({
    required this.title,
    required this.content,
    this.status = 'active',
    this.id = 0,
  });
}

class NotiFetchDetail extends NotiCreateEvent {
  NotiFetchDetail({
    required this.id,
  });

  final int id;
}

class NotiDeleteFile extends NotiCreateEvent {
  NotiDeleteFile({
    required this.notificationId,
    required this.attachmentId,
  });

  final int notificationId;
  final int attachmentId;
}

class NotiDraftDelete extends NotiCreateEvent {
  NotiDraftDelete({
    required this.id,
  });

  final int id;
}

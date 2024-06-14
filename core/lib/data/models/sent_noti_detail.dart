import 'teacher_detail.dart';

class SentNotiDetail {
  final Notification notification;
  final List<PupilNoti> pupils;

  SentNotiDetail({required this.notification, required this.pupils});

  factory SentNotiDetail.fromMap(Map<String, dynamic> map) {
    return SentNotiDetail(
      notification: Notification.fromMap(map['notification']),
      pupils:
          List<PupilNoti>.from(map['pupils'].map((x) => PupilNoti.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notification': notification.toMap(),
      'pupils': List<dynamic>.from(pupils.map((x) => x.toMap())),
    };
  }

  factory SentNotiDetail.empty() {
    return SentNotiDetail(
      notification: Notification.empty(),
      pupils: [],
    );
  }
}

class Notification {
  final int id;
  final int schoolId;
  final String title;
  final String content;
  final List<Attachment> attachments;
  final int toClassId;
  final String entityType;
  final String entityId;
  final String status;
  final String createdAt;
  final String createdBy;

  Notification({
    required this.id,
    required this.schoolId,
    required this.title,
    required this.content,
    required this.attachments,
    required this.toClassId,
    required this.entityType,
    required this.entityId,
    required this.status,
    required this.createdAt,
    required this.createdBy,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      schoolId: map['school_id'],
      title: map['title'],
      content: map['content'],
      attachments: List<Attachment>.from(
          map['attachments'].map((x) => Attachment.fromMap(x))),
      toClassId: map['to_class_id'],
      entityType: map['entity_type'],
      entityId: map['entity_id'],
      status: map['status'],
      createdAt: map['created_at'],
      createdBy: map['created_by'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'school_id': schoolId,
      'title': title,
      'content': content,
      'attachments': List<dynamic>.from(attachments.map((x) => x.toMap())),
      'to_class_id': toClassId,
      'entity_type': entityType,
      'entity_id': entityId,
      'status': status,
      'created_at': createdAt,
      'created_by': createdBy,
    };
  }

  factory Notification.empty() {
    return Notification(
      id: 0,
      schoolId: 0,
      title: '',
      content: '',
      attachments: [],
      toClassId: 0,
      entityType: '',
      entityId: '',
      status: '',
      createdAt: '',
      createdBy: '',
    );
  }
}

class Attachment {
  final int id;
  final int resourceId;
  final String url;
  final String fileType;

  Attachment({
    required this.id,
    required this.resourceId,
    required this.url,
    required this.fileType,
  });

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      id: map['id'],
      resourceId: map['resource_id'],
      url: map['url'],
      fileType: map['file_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resource_id': resourceId,
      'url': url,
      'file_type': fileType,
    };
  }
}

class PupilNoti {
  final int pupilId;
  final String userId;
  final int classId;
  final int customerId;
  final String fullName;
  final String userKey;
  final int parentId;
  final String className;
  final UrlImage urlImage;
  final String email;
  final String? selected;

  PupilNoti({
    required this.pupilId,
    required this.userId,
    required this.classId,
    required this.customerId,
    required this.fullName,
    required this.userKey,
    required this.parentId,
    required this.className,
    required this.urlImage,
    required this.email,
    this.selected,
  });

  factory PupilNoti.fromMap(Map<String, dynamic> map) {
    return PupilNoti(
      pupilId: map['pupil_id'],
      userId: map['user_id'],
      classId: map['class_id'],
      customerId: map['customer_id'],
      fullName: map['full_name'],
      userKey: map['user_key'],
      parentId: map['parent_id'],
      className: map['class_name'],
      urlImage: UrlImage.fromMap(map['url_image']),
      email: map['email'],
      selected: map['selected'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pupil_id': pupilId,
      'user_id': userId,
      'class_id': classId,
      'customer_id': customerId,
      'full_name': fullName,
      'user_key': userKey,
      'parent_id': parentId,
      'class_name': className,
      'url_image': urlImage.toMap(),
      'email': email,
      'selected': selected,
    };
  }
}

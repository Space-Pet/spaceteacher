import 'class_teacher.dart';
import 'pupil_in_class.dart';

class SentNotiDetail {
  final NotificationDetail notification;
  final List<PupilInClass> pupils;
  final List<ClassTeacher> classes;

  SentNotiDetail({
    required this.notification,
    required this.pupils,
    required this.classes,
  });

  factory SentNotiDetail.fromMap(Map<String, dynamic> map) {
    return SentNotiDetail(
      notification: NotificationDetail.fromMap(map['notification']),
      pupils: List<PupilInClass>.from(map['pupils']
          .map((x) => PupilInClass.fromJson(x as Map<String, dynamic>))),
      classes: List<ClassTeacher>.from(map['classes']
          .map((x) => ClassTeacher.fromJson(x as Map<String, dynamic>))),
    );
  }

  factory SentNotiDetail.empty() {
    return SentNotiDetail(
      notification: NotificationDetail.empty(),
      pupils: [],
      classes: [],
    );
  }
}

class NotificationDetail {
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

  NotificationDetail({
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

  factory NotificationDetail.fromMap(Map<String, dynamic> map) {
    return NotificationDetail(
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

  factory NotificationDetail.empty() {
    return NotificationDetail(
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

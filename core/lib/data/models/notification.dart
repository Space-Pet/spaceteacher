import 'dart:convert';


class NotificationData {
  final List<NotificationItem> data;
  final NotificationLinks links;
  final NotificationMeta meta;

  NotificationData({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory NotificationData.fakeData() => NotificationData(
        data: List.generate(
          10,
          (index) => NotificationItem(
            id: index,
            schoolId: index,
            title: 'title $index',
            content: 'content $index',
            excerpt: 'excerpt $index',
            createdAt: '2021-09-01 00:00:00',
            createdBy: index,
          ),
        ),
        links: NotificationLinks.empty(),
        meta: NotificationMeta.empty(),
      );

  factory NotificationData. empty() => NotificationData(
        data: [],
        links: NotificationLinks.empty(),
        meta: NotificationMeta.empty(),
      );

  factory NotificationData.fromMap(dynamic map) {
    if (map == null || map['data'].isEmpty || map['data'] == null) {
      return NotificationData.empty();
    }

    return NotificationData(
      data: List<NotificationItem>.from(
        (map['data'] as List<dynamic>).map(
          (item) => NotificationItem.fromMap(item as Map<String, dynamic>),
        ),
      ),
      links: NotificationLinks.empty(),
      meta: NotificationMeta.empty(),
      // links: NotificationLinks.fromMap(map['links']),
      // meta: NotificationMeta.fromMap(map['meta']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': List<dynamic>.from(
        data.map(
          (x) => x.toMap(),
        ),
      ),
      'links': links.toMap(),
      'meta': meta.toMap(),
    };
  }

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'NotificationData(data: $data, links: $links, meta: $meta)';
}

class NotificationItem {
  final int id;
  final int schoolId;
  final String title;
  final String content;
  final String excerpt;
  final String createdAt;
  final int createdBy;

  final dynamic attachment;
  final dynamic viewerId;
  final dynamic pupilId;
  final dynamic viewedAt;
  final String? toUser;
  final String? updatedAt;
  final String? status;

  NotificationItem({
    required this.id,
    required this.schoolId,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.createdAt,
    required this.createdBy,
    this.attachment,
    this.viewerId,
    this.pupilId,
    this.viewedAt,
    this.toUser,
    this.updatedAt,
    this.status,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    final createdBy = map['created_by'];

    return NotificationItem(
      id: map['id'] ?? 0,
      schoolId: map['school_id'] ?? 0,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      excerpt: map['excerpt'] ?? '',
      attachment: map['attachment'],
      viewerId: map['viewer_id'],
      pupilId: map['pupil_id'],
      toUser: map['to_user'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      viewedAt: map['viewed_at'] ?? '',
      createdBy: createdBy is String ? int.parse(createdBy) : createdBy,
      status: map['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'school_id': schoolId,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'attachment': attachment,
      'viewer_id': viewerId,
      'pupil_id': pupilId,
      'to_user': toUser,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'viewed_at': viewedAt,
      'created_by': createdBy,
      'status': status,
    };
  }

  factory NotificationItem.fromJson(String source) =>
      NotificationItem.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  static NotificationItem empty() {
    return NotificationItem(
      id: 0,
      schoolId: 0,
      title: '',
      content: '',
      excerpt: '',
      attachment: '',
      viewerId: '',
      pupilId: '',
      toUser: '',
      createdAt: '',
      updatedAt: '',
      viewedAt: '',
      createdBy: 0,
      status: 'active',
    );
  }
}

class NotificationLinks {
  final String? first;
  final String? last;
  final dynamic prev;
  final dynamic next;

  NotificationLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory NotificationLinks.empty() =>
      NotificationLinks(first: '', last: '', prev: '', next: '');

  factory NotificationLinks.fromMap(Map<String, dynamic> map) {
    return NotificationLinks(
      first: map['first'],
      last: map['last'],
      prev: map['prev'],
      next: map['next'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }

  factory NotificationLinks.fromJson(String source) =>
      NotificationLinks.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'NotificationLinks(first: $first, last: $last, prev: $prev, next: $next)';
}

class NotificationMeta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<NotificationMetaLink> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  NotificationMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory NotificationMeta.empty() => NotificationMeta(
        currentPage: 0,
        from: 0,
        lastPage: 0,
        links: [],
        path: '',
        perPage: 0,
        to: 0,
        total: 0,
      );

  factory NotificationMeta.fromMap(Map<String, dynamic> map) {
    return NotificationMeta(
      currentPage: map['current_page'],
      from: map['from'],
      lastPage: map['last_page'],
      links: List<NotificationMetaLink>.from(
        map['links']?.map(
          NotificationMetaLink.fromMap,
        ),
      ),
      path: map['path'],
      perPage: map['per_page'],
      to: map['to'],
      total: map['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': List<dynamic>.from(
        links.map(
          (x) => x.toMap(),
        ),
      ),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }

  factory NotificationMeta.fromJson(String source) =>
      NotificationMeta.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'NotificationMeta(currentPage: $currentPage, from: $from, lastPage: $lastPage, links: $links, path: $path, perPage: $perPage, to: $to, total: $total)';
}

class NotificationMetaLink {
  final dynamic url;
  final String label;
  final bool active;

  NotificationMetaLink({
    required this.url,
    required this.label,
    required this.active,
  });

  factory NotificationMetaLink.fromMap(Map<String, dynamic> map) {
    return NotificationMetaLink(
      url: map['url'],
      label: map['label'],
      active: map['active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }

  factory NotificationMetaLink.fromJson(String source) =>
      NotificationMetaLink.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

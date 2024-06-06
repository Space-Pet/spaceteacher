class GalleryClass {
  int classId;
  String className;

  GalleryClass({
    required this.classId,
    required this.className,
  });

  factory GalleryClass.fromMap(Map<String, dynamic> map) {
    return GalleryClass(
      classId: map['class_id'],
      className: map['class_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'class_name': className,
    };
  }

  factory GalleryClass.empty() {
    return GalleryClass(
      classId: 0,
      className: 'Chọn lớp',
    );
  }
}

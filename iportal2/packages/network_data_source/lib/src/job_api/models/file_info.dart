class FileInfo {
  final String attachment;
  final String comment;
  final DateTime uploaddate;
  FileInfo({
    required this.attachment,
    required this.comment,
    required this.uploaddate
  });

  factory FileInfo.fromMap(Map<String, dynamic> map) {
    return FileInfo(
      attachment: map['attachment'],
      comment: map['comment'],
      uploaddate: map['upload_date'] != null
    ? DateTime.tryParse(map['upload_date']) ?? DateTime.now()
        : DateTime.now(),
    );
  }
}
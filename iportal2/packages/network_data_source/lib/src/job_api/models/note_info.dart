class NoteInfo {
  final String note;
  final DateTime createDate;
  final String title;
  final String userName;
  NoteInfo({
    required this.note,
    required this.createDate,
    required this.title,
    required this.userName
  });

  factory NoteInfo.fromMap(Map<String, dynamic> map) {
      final userDetail = map['user_detail'];
      final userName = userDetail['username'] ?? '';
    return NoteInfo(
      userName: userName,
      title: map['title'],
      note: map['note'],
      createDate: map['create_date'] != null
          ? DateTime.tryParse(map['create_date']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
class Comment {
  final String commentId;
  final String teacherId;
  final String teacherName;
  final String teacherimg;
  final String huyHieuName;
  final String huyHieuImg;
  final String weekDayNote;
  final String commentNote;
  final String commentDate;
  final String commentTimePost;
  const Comment(
      {required this.commentDate,
      required this.commentId,
      required this.commentNote,
      required this.commentTimePost,
      required this.huyHieuImg,
      required this.huyHieuName,
      required this.teacherId,
      required this.teacherName,
      required this.teacherimg,
      required this.weekDayNote});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentDate: json['comment_date'] ?? '',
        commentId: json['comment_mn_id'] ?? '',
        commentNote: json['comment_note'] ?? '',
        commentTimePost: json['comment_time_post'] ?? '',
        huyHieuImg: json['huy_hieu_img'] ??
            'https://cdn-icons-png.freepik.com/512/9776/9776920.png',
        huyHieuName: json['huy_hieu_name'] ?? '',
        teacherId: json['teacher_id'] ?? '',
        teacherName: json['teacher_name'] ?? '',
        teacherimg: json['teacher_img'] ?? '',
        weekDayNote: json['week_day_note'] ?? '');
  }

  factory Comment.empty() => const Comment(
        commentDate: 'No Comment',
        commentId: 'No Comment',
        commentNote: 'No Comment',
        commentTimePost: 'No Comment',
        huyHieuImg: 'https://cdn-icons-png.freepik.com/512/9776/9776920.png',
        huyHieuName: 'No Comment',
        teacherId: 'No Comment',
        teacherName: 'No Comment',
        teacherimg: 'No Comment',
        weekDayNote: 'No Comment',
      );

  static List<Comment> fakeData() => List.generate(
      10,
      (index) => const Comment(
            commentDate: '22-01-2024',
            commentId: '1',
            commentNote:
                'Chúc mừng con đã hoàn thành tốt bài kiểm tra tuần này',
            commentTimePost: '22:00',
            huyHieuImg: 'imgurl',
            huyHieuName: 'Huy hiệu 1',
            teacherId: '1',
            teacherName: 'Nguyễn Văn A',
            teacherimg: 'imgurl',
            weekDayNote: 'Thứ 2',
          ));
}

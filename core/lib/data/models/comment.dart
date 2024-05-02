
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
        huyHieuImg: json['huy_hieu_img'] ?? '',
        huyHieuName: json['huy_hieu_name'] ?? '',
        teacherId: json['teacher_id'] ?? '',
        teacherName: json['teacher_name'] ?? '',
        teacherimg: json['teacher_img'] ?? '',
        weekDayNote: json['week_day_note'] ?? '');
  }

  factory Comment.empty() => const Comment(
      commentDate: 'eee',
      commentId: '',
      commentNote: '',
      commentTimePost: '',
      huyHieuImg: '',
      huyHieuName: '',
      teacherId: '',
      teacherName: '',
      teacherimg: '',
      weekDayNote: '');
}

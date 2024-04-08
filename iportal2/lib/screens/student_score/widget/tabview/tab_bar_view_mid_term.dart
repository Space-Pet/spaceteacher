import 'package:flutter/material.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:iportal2/screens/student_score/widget/score_card_subject/score_subject_model.dart';
import 'package:iportal2/screens/student_score/widget/tabview/tab_bar_view_monet.dart';
import 'package:iportal2/screens/student_score/widget/tabview/tab_bar_view_other.dart';

class TabBarViewMidTerm extends StatelessWidget {
  final String selectedScoreType;
  const TabBarViewMidTerm({
    super.key,
    required this.selectedScoreType,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: TabViewOther(),
    );
  }
}

final List<ScoreSubjectModel> scoreSubjectList = [
  ScoreSubjectModel(
    id: 1,
    score: "9.0",
    name: 'Tiếng Việt',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 2,
    score: "9.0",
    name: 'Toán',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 3,
    score: "9.0",
    name: 'Tiếng Anh',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 4,
    score: "9.0",
    name: 'Hóa học',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 5,
    score: "9.0",
    name: 'Vật lý',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 6,
    score: "9.0",
    name: 'Lịch sử',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 7,
    score: "9.0",
    name: 'Địa lý',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 8,
    score: "9.0",
    name: 'Tin học',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 9,
    score: "9.0",
    name: 'GDCD',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 10,
    score: "9.0",
    name: 'GDTC',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 11,
    score: "9.0",
    name: 'GDQP',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'score',
  ),
  ScoreSubjectModel(
    id: 12,
    score: "9.0",
    name: 'Âm nhạc',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'level',
  ),
  ScoreSubjectModel(
    id: 13,
    score: "9.0",
    name: 'Mỹ thuật',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'level',
  ),
  ScoreSubjectModel(
    id: 14,
    score: "9.0",
    name: 'Đạo đức',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Không đạt',
    typeScore: 'level',
  ),
  ScoreSubjectModel(
    id: 15,
    score: "9.0",
    name: 'Thể dục',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Không đạt',
    typeScore: 'level',
  ),
];

final List<ScoreSubjectModel> scoreSubjectListOther = [
  ScoreSubjectModel(
    id: 1,
    score: "9.0",
    name: 'IELTS',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'IELTS',
  ),
  ScoreSubjectModel(
    id: 2,
    score: "9.0",
    name: 'SCIENCE',
    teacherName: 'Nguyễn Hồng Ân',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    advice:
        'Chữ viêt sạch đẹp, đọc bài lưu loát. Nắm vững kiến thức luyện từ và câu.',
    result: 'Tốt',
    typeScore: 'SCIENCE',
  ),
];

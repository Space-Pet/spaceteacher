import 'package:teacher/model/subject_model.dart';

class MockSubjectData {
  final int? id;
  final String? nameObservation;
  final int? typeObservation;
  final SubjectModel? subjectModel;
  final String? time;
  final String? descriptionSubjectLesson;

  MockSubjectData(
      {this.id,
      this.nameObservation,
      this.typeObservation,
      this.subjectModel,
      this.time,
      this.descriptionSubjectLesson});
}

List<MockSubjectData> listMockSubjectData = [
  MockSubjectData(
    id: 1,
    nameObservation: 'Dự giờ Toán - Lớp 6.1',
    typeObservation: 4,
    subjectModel: SubjectModel(
      subjectName: 'Toán',
      tietNum: 1,
      className: '6.1',
      teacherName: 'Nguyễn Hoàng Vi Khương',
    ),
    time: '7:45 - 8:15',
    descriptionSubjectLesson: 'Bài 2: Diện tích hình Tròn',
  ),
  MockSubjectData(
    id: 2,
    nameObservation: 'Dự giờ Toán - Lớp 6.3',
    typeObservation: 1,
    subjectModel: SubjectModel(
      subjectName: 'Toán',
      tietNum: 1,
      className: '6.3',
      teacherName: 'Nguyễn Thúy Quỳnh',
    ),
    time: '7:45 - 8:15',
    descriptionSubjectLesson: 'Bài 2: Diện tích hình Tròn',
  ),
  MockSubjectData(
    id: 3,
    nameObservation: 'Dự giờ Toán - Lớp 6.2',
    typeObservation: 2,
    subjectModel: SubjectModel(
      subjectName: 'Toán',
      tietNum: 5,
      className: '6.2',
      teacherName: 'Trần Anh Thư',
    ),
    time: '7:45 - 8:15',
    descriptionSubjectLesson: 'Bài 2: Diện tích hình chữ nhật',
  ),
  MockSubjectData(
    id: 4,
    nameObservation: 'Dự giờ Toán - Lớp 6.5',
    typeObservation: 3,
    subjectModel: SubjectModel(
      subjectName: 'Toán',
      tietNum: 6,
      className: '6.2',
      teacherName: 'Trần Anh Thư',
    ),
    time: '7:45 - 8:15',
    descriptionSubjectLesson: 'Bài 2: Diện tích hình chữ nhật',
  ),
];

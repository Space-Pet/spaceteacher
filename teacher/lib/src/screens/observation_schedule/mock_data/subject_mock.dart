import 'package:teacher/model/subject_model.dart';
import 'package:teacher/model/teacher_info_model.dart';
import 'package:teacher/model/url_image_model.dart';

class MockSubjectData {
  final int? id;
  final String? nameObservation;
  final int? typeObservation;
  final SubjectModel? subjectModel;
  final String? time;
  final String? descriptionSubjectLesson;
  final bool? isChoosed;

  MockSubjectData(
      {this.id,
      this.nameObservation,
      this.typeObservation,
      this.subjectModel,
      this.time,
      this.descriptionSubjectLesson,
      this.isChoosed = false});
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

List<String> mockSubjectData = [
  'Toán',
  'Ngữ văn',
  'Ngoại ngữ 1',
  'Lịch sử',
  'Địa lý',
  'Khoa học tự nhiên',
  'Giáo dục thể chất',
  'Giáo dục công dân',
  'Âm nhạc',
  'Mỹ thuật',
  'Công nghệ',
  'Tin học',
];

List<String> mockClassData = [
  'Lớp 6.1',
  'Lớp 6.2',
  'Lớp 6.3',
  'Lớp 6.4',
  'Lớp 6.5',
];

List<String> mockTietData = [
  'Tiết 1',
  'Tiết 2',
  'Tiết 3',
  'Tiết 4',
  'Tiết 5',
];

List<TeacherInfo> mockTeacherInfoData = [
  TeacherInfo(
    teacherId: 1,
    fullName: 'Nguyễn Hoàng Vi Khương',
    urlImageModel: UrlImageModel(),
    mainSubject: 'Toán',
    schoolName: '6.5',
  ),
  TeacherInfo(
    teacherId: 2,
    fullName: 'Nguyễn Thúy Quỳnh',
    urlImageModel: UrlImageModel(),
    mainSubject: 'Ngữ văn',
    schoolName: '6.1',
  ),
  TeacherInfo(
    teacherId: 3,
    fullName: 'Trần Anh Thư',
    urlImageModel: UrlImageModel(),
    mainSubject: 'Anh văn',
    schoolName: '6.2',
  ),
  TeacherInfo(
    teacherId: 4,
    fullName: 'Nguyễn Thị Hồng',
    urlImageModel: UrlImageModel(),
    mainSubject: 'Toán',
    schoolName: '6.3',
  ),
];

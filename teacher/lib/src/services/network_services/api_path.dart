import 'package:teacher/enviroment.dart';

class ApiPath {
  static String baseUrl = Enviroment.apiUrl;

  static String login = '${baseUrl}login';
  static String loginWithQR = '${baseUrl}login-QRCode';
  static String logout = '${baseUrl}logout';
  static String getInfoStudent = '${baseUrl}member/pupil/';
  static String getListContactStudent = '${baseUrl}member/pupil/class';
  static String getListStudentFollowClass = '${baseUrl}member/class';
  static String getEvaluationForm =
      '${baseUrl}member/bieu-mau-danh-gia/completed';
  static String getEvaluationFormFollowStudent =
      '${baseUrl}member/bieu-mau-danh-gia/result';
  static String getListNotifications =
      '${baseUrl}member/announce/notifications';
  static String getDetailNotification =
      '${baseUrl}member/announce/notification/';
  static String getListTeacher = '${baseUrl}member/teacher/pupil';
  static String getListGalleryAlbum = '${baseUrl}member/gallery/pupil';
  static String getDetailGalleryImage = '${baseUrl}member/gallery/show';
  static String getSchedulesStudent = 'https://apitest-iportal.nhg.vn.api.php';
  static String getHighSchoolScore = 'https://apitest-iportal.nhg.vn.api.php';
  static String getPrimarySchoolScore = 'https://apitest-iportal.nhg.vn.api.php';
}

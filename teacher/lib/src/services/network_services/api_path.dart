import 'package:teacher/enviroment.dart';

class ApiPath {
  static String baseUrl = Enviroment.apiUrl;

  static String login = '${baseUrl}login';
  static String loginStaff = '${baseUrl}staff-login';
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
  static String getListGalleryAlbum = '${baseUrl}staff/gallery/teacher';
  static String getDetailGalleryImage = '${baseUrl}staff/gallery/show';
  static String getSchedulesStudent = 'https://test-iportal.nhg.vn.api.php';
  static String getHighSchoolScore = 'https://test-iportal.nhg.vn.api.php';
  static String getPrimarySchoolScore = 'https://test-iportal.nhg.vn.api.php';
  static String getEslScore = 'https://test-iportal.nhg.vn.api.php';
  static String getConductPrimarySchool = 'https://test-iportal.nhg.vn.api.php';

  static String getMenuInWeek = 'https://test-iportal.nhg.vn.api.php';
  static String getHistoryAbsenceStudent =
      '$baseUrl/member/leave-application/pupil';
  static String postAbsenceApplication =
      '$baseUrl/member/leave-application/pupil';
  static String getRegisterNotebookStudent =
      'https://test-iportal.nhg.vn.api.php';
  static String getRegisterNotebookTeacher =
      'https://apitest-iportal.nhg.vn.api.php';
  static String postRegisterNotebook = 'https://apitest-iportal.nhg.vn.api.php';
  static String deleteRegisterNotebook =
      'https://apitest-iportal.nhg.vn.api.php';
  static String getListBusRoutes = '${baseUrl}staff/school-bus/routes';
  static String getListBusSchedule = '${baseUrl}staff/school-bus';
  static String getObservationSchedule = '${baseUrl}staff/';

  static String getConversation = '${baseUrl}staff/conversations';

  static String hourlyAssessment = 'https://test-iportal.nhg.vn/api/api.php';
}

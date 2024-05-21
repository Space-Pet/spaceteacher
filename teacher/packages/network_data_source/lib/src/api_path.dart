class ApiPath {
  static const String _apiV1 = '/api/v1';
  static String loginStaff = '$_apiV1/staff-login';
  static String loginWithQR = '$_apiV1/login-QRCode';
  static String logout = '$_apiV1/logout';
  static String getInfoStudent = '$_apiV1/member/pupil/';
  static String getListContactStudent = '$_apiV1/member/pupil/class';
  static String getListStudentFollowClass = '$_apiV1/member/class';
  static String getEvaluationForm =
      '$_apiV1/member/bieu-mau-danh-gia/completed';
  static String getEvaluationFormFollowStudent =
      '$_apiV1/member/bieu-mau-danh-gia/result';
  static String getListNotifications = '$_apiV1/member/announce/notifications';
  static String getDetailNotification = '$_apiV1/member/announce/notification/';
  static String getListTeacher = '$_apiV1/member/teacher/pupil';
  static String getListGalleryAlbum = '$_apiV1/staff/gallery/teacher';
  static String getDetailGalleryImage = '$_apiV1/staff/gallery/show';
  static String getSchedulesStudent = '.api.php'; //        [TODO]
  static String getHighSchoolScore = '.api.php'; //         [TODO]
  static String getPrimarySchoolScore = '.api.php'; //      [TODO]
  static String getEslScore = '.api.php'; //                [TODO]
  static String getConductPrimarySchool = '.api.php'; //    [TODO]

  static String getMenuInWeek = '/api.php?act=weeklymenu&type=json'; //              [TODO]
  static String getHistoryAbsenceStudent =
      '$_apiV1/member/leave-application/pupil';
  static String postAbsenceApplication =
      '$_apiV1/member/leave-application/pupil';
  static String getRegisterNotebookStudent = '.api.php'; // [TODO]
  static String getRegisterNotebookTeacher = '.api.php'; // [TODO]
  static String postRegisterNotebook = '.api.php'; //       [TODO]
  static String deleteRegisterNotebook = '.api.php'; //     [TODO]
  static String getListBusRoutes = '$_apiV1/staff/school-bus/routes';
  static String getListBusSchedule = '$_apiV1/staff/school-bus';
  static String getSurvey = '$_apiV1/member/survey/question';
}

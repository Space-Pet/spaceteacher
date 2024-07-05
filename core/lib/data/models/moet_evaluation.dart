class Assessment {
  String userId;
  String schoolBrand;
  String teacherId;
  String teacherFullname;
  String lessonRegisterId;
  String lessonRegisterSchoolName;
  String lessonRegisterClassName;
  String lessonRegisterTeacherName;
  String lessonRegisterSubjectName;
  String lessonRegisterDate;
  String lessonRegisterRoomName;
  String? lessonRegisterLessonTitle;
  String? updated;
  String? xepLoai;
  String? tongDiem;
  String diemType;
  List<Criteria> listMoetCriteria;

  Assessment({
    required this.userId,
    required this.schoolBrand,
    required this.teacherId,
    required this.teacherFullname,
    required this.lessonRegisterId,
    required this.lessonRegisterSchoolName,
    required this.lessonRegisterClassName,
    required this.lessonRegisterTeacherName,
    required this.lessonRegisterSubjectName,
    required this.lessonRegisterDate,
    required this.lessonRegisterRoomName,
    this.lessonRegisterLessonTitle,
    this.updated,
    this.xepLoai,
    this.tongDiem,
    required this.diemType,
    required this.listMoetCriteria,
  });

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
      userId: map['user_id'],
      schoolBrand: map['school_brand'],
      teacherId: map['teacher_id'],
      teacherFullname: map['teacher_fullname'],
      lessonRegisterId: map['lesson_register_id'],
      lessonRegisterSchoolName: map['lesson_register_school_name'],
      lessonRegisterClassName: map['lesson_register_class_name'],
      lessonRegisterTeacherName: map['lesson_register_teacher_name'],
      lessonRegisterSubjectName: map['lesson_register_subject_name'],
      lessonRegisterDate: map['lesson_register_date'],
      lessonRegisterRoomName: map['lesson_register_room_name'],
      lessonRegisterLessonTitle: map['lesson_register_lesson_title'],
      updated: map['updated'],
      xepLoai: map['xep_loai'],
      tongDiem: map['tong_diem'],
      diemType: map['diem_type'],
      listMoetCriteria: List<Criteria>.from(
          map['data']?.map((x) => Criteria.fromMap(x as Map<String, dynamic>))),
    );
  }

  factory Assessment.empty() {
    return Assessment(
      userId: '',
      schoolBrand: '',
      teacherId: '',
      teacherFullname: '',
      lessonRegisterId: '',
      lessonRegisterSchoolName: '',
      lessonRegisterClassName: '',
      lessonRegisterTeacherName: '',
      lessonRegisterSubjectName: '',
      lessonRegisterDate: '',
      lessonRegisterRoomName: '',
      lessonRegisterLessonTitle: '',
      updated: '',
      xepLoai: '',
      tongDiem: '',
      diemType: '',
      listMoetCriteria: [],
    );
  }

  factory Assessment.fakeData() {
    return Assessment(
        userId: '10014243',
        schoolBrand: 'ischool',
        teacherId: '10000586',
        teacherFullname: 'Vũ Thế Dương',
        lessonRegisterId: '5878',
        lessonRegisterSchoolName: 'ISCHOOL QUY NHƠN',
        lessonRegisterClassName: 'Khối 10 ( Vật lý )A01',
        lessonRegisterTeacherName: 'Nguyễn Thị Cẩm Vân',
        lessonRegisterSubjectName: 'Toán',
        lessonRegisterDate: '2024-02-26',
        lessonRegisterRoomName: 'P. C13',
        lessonRegisterLessonTitle: null,
        updated: 'no',
        xepLoai: null,
        tongDiem: null,
        diemType: 'float',
        listMoetCriteria: List.generate(
          10,
          (index) => Criteria(
            stt: index,
            noteId: '10000586',
            tieuChiDanhMuc: '1.1',
            tieuChiTongDiem: 10,
            tieuChiNoiDung: 'Nắm vững kiến thức',
            tieuChiDiem: 10,
            diemDat: null,
            nhanXet: null,
          ),
        ));
  }
}

class Criteria {
  int stt;
  String noteId;
  String tieuChiDanhMuc;
  num? tieuChiTongDiem;
  num? tieuChiDiemMax;
  String? tieuChiNoiDung;
  String? tieuChiNoiDungGiaoVien;
  String? tieuChiNoiDungHocSinh;
  num? tieuChiDiem;
  String? diemDat;
  String? nhanXet;

  Criteria({
    required this.stt,
    required this.noteId,
    required this.tieuChiDanhMuc,
    this.tieuChiTongDiem,
    this.tieuChiDiemMax,
    this.tieuChiNoiDung,
    this.tieuChiNoiDungGiaoVien,
    this.tieuChiNoiDungHocSinh,
    this.tieuChiDiem,
    this.diemDat,
    this.nhanXet,
  });

  factory Criteria.fromMap(Map<String, dynamic> map) {
    return Criteria(
      stt: map['STT'],
      noteId: map['NOTE_ID'],
      tieuChiDanhMuc: map['tieu_chi_danh_muc'],
      tieuChiTongDiem: map['tieu_chi_tong_diem'],
      tieuChiDiemMax: map['tieu_chi_diem_max'],
      tieuChiNoiDung: map['tieu_chi_noi_dung'],
      tieuChiNoiDungGiaoVien: map['tieu_chi_noi_dung_giao_vien'],
      tieuChiNoiDungHocSinh: map['tieu_chi_noi_dung_hoc_sinh'],
      tieuChiDiem: map['tieu_chi_diem'],
      diemDat: map['diem_dat'],
      nhanXet: map['nhan_xet'],
    );
  }

  Criteria copyWith({
    int? stt,
    String? noteId,
    String? tieuChiDanhMuc,
    num? tieuChiTongDiem,
    num? tieuChiDiemMax,
    String? tieuChiNoiDung,
    String? tieuChiNoiDungGiaoVien,
    String? tieuChiNoiDungHocSinh,
    num? tieuChiDiem,
    String? diemDat,
    String? nhanXet,
  }) {
    return Criteria(
      stt: stt ?? this.stt,
      noteId: noteId ?? this.noteId,
      tieuChiDanhMuc: tieuChiDanhMuc ?? this.tieuChiDanhMuc,
      tieuChiTongDiem: tieuChiTongDiem ?? this.tieuChiTongDiem,
      tieuChiDiemMax: tieuChiDiemMax ?? this.tieuChiDiemMax,
      tieuChiNoiDung: tieuChiNoiDung ?? this.tieuChiNoiDung,
      tieuChiNoiDungGiaoVien:
          tieuChiNoiDungGiaoVien ?? this.tieuChiNoiDungGiaoVien,
      tieuChiNoiDungHocSinh:
          tieuChiNoiDungHocSinh ?? this.tieuChiNoiDungHocSinh,
      tieuChiDiem: tieuChiDiem ?? this.tieuChiDiem,
      diemDat: diemDat ?? this.diemDat,
      nhanXet: nhanXet ?? this.nhanXet,
    );
  }
}

part of 'class_score_bloc.dart';

enum Status {
  init,
  loadingGetMoet,
  successGetMoet,

  loadingGetSemester,
  successGetSemester,

  loadingGetStudent,
  successGetStudent,

  laodingPostMOET,
  successPostMOET,
  failPostMOET,

  loadingMarkType,
  successMarkType,

  loadingGetFormMoet,
  successGetFormMoet,

  loadingGetFormESL,
  successGetFormESL,

  loadingPrimaryConduct,
  successPrimaryConduct,

  loadingFormConduct,
  successFormConduct,

  updateTerm,
}

class ClassScoreState extends Equatable {
  final Status status;
  final Data dataMoet;
  final MoetHighData moetHighData;
  final List<Semester> semesterTabTeaching;
  final PhoneBookStudent phoneBookStudent;
  final String numberInputScore;
  final String message;
  final Semester termType;
  final List<MarkTypeColumn> markType;
  final FormMoet formMoet;
  final List<FormScoreESL> formScoreESL;
  final PrimaryConduct primaryConduct;
  final HanhKiemData hanhKiemData;
  List<ConductScore>? conductScore;
  ClassScoreState({
    this.conductScore,
    required this.primaryConduct,
    required this.hanhKiemData,
    required this.formMoet,
    required this.formScoreESL,
    required this.markType,
    required this.moetHighData,
    this.semesterTabTeaching = const [],
    this.status = Status.init,
    required this.dataMoet,
    required this.phoneBookStudent,
    this.numberInputScore = '',
    this.message = '',
    this.termType = const Semester(title: 'Không dữ liệu', value: 0),
  });
  @override
  List<Object?> get props => [
        conductScore,
        hanhKiemData,
        primaryConduct,
        formScoreESL,
        formMoet,
        markType,
        termType,
        numberInputScore,
        status,
        dataMoet,
        semesterTabTeaching,
        phoneBookStudent,
        message,
        moetHighData,
      ];
  ClassScoreState copyWith({
    List<ConductScore>? conductScore,
    HanhKiemData? hanhKiemData,
    PrimaryConduct? primaryConduct,
    List<FormScoreESL>? formScoreESL,
    FormMoet? formMoet,
    List<MarkTypeColumn>? markType,
    MoetHighData? moetHighScore,
    Semester? termType,
    String? numberInputScore,
    PhoneBookStudent? phoneBookStudent,
    Status? status,
    Data? dataMoet,
    List<Semester>? semesterTabTeaching,
    String? message,
  }) {
    return ClassScoreState(
      conductScore: conductScore ?? this.conductScore,
      hanhKiemData: hanhKiemData ?? this.hanhKiemData,
      primaryConduct: primaryConduct ?? this.primaryConduct,
      formScoreESL: formScoreESL ?? this.formScoreESL,
      formMoet: formMoet ?? this.formMoet,
      markType: markType ?? this.markType,
      moetHighData: moetHighScore ?? this.moetHighData,
      termType: termType ?? this.termType,
      message: message ?? this.message,
      numberInputScore: numberInputScore ?? this.numberInputScore,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      semesterTabTeaching: semesterTabTeaching ?? this.semesterTabTeaching,
      status: status ?? this.status,
      dataMoet: dataMoet ?? this.dataMoet,
    );
  }
}

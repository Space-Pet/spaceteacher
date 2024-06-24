part of 'register_notebook_bloc.dart';

sealed class RegisterNotebookEvent {}

class RegisterNotebookFetchData extends RegisterNotebookEvent {
  RegisterNotebookFetchData();
}

class RegisterSelectDate extends RegisterNotebookEvent {
  RegisterSelectDate({
    required this.datePicked,
    this.classSelect = 1,
  });
  final int classSelect;
  final DateTime datePicked;
}

class GetViolationData extends RegisterNotebookEvent {
  final String userKey;
  final String classId;
  GetViolationData({
    required this.classId,
    required this.userKey,
  });
}

class GetListViolation extends RegisterNotebookEvent {}

class PostRegister extends RegisterNotebookEvent {
  final String lessionId;
  final String lessionTitle;
  final String lessionNote;
  final String tietPpct;
  final String lessionRank;
  final String danDoBaoBai;
  final File fileBaoBai;
  final String linkBaoBai;
  final String hanNop;
  final String userKey;
  PostRegister({
    required this.danDoBaoBai,
    required this.fileBaoBai,
    required this.hanNop,
    required this.lessionId,
    required this.lessionNote,
    required this.lessionRank,
    required this.lessionTitle,
    required this.linkBaoBai,
    required this.tietPpct,
    required this.userKey,
  });
}

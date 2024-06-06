part of 'register_notebook_bloc.dart';

sealed class RegisterNotebookEvent {}

class RegisterNotebookFetchData extends RegisterNotebookEvent {
  RegisterNotebookFetchData();
}

class RegisterSelectDate extends RegisterNotebookEvent {
  RegisterSelectDate({required this.datePicked});

  final DateTime datePicked;
}

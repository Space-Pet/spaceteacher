import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  CommentBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(CommentState(
          comment: Comment.fakeData(),
          listReportStudent: ListReportStudent.fakeData(),
        )) {
    on<GetComment>(_onGetComment);

    on<GetListReportStudent>(_onGetListReportStudent);

    on<GetReportStudent>(_onGetReportStudent);
    on<ScoreTxtTermChange>(_onUpdateTerm);
  }

  void _onUpdateTerm(
    ScoreTxtTermChange event,
    Emitter<CommentState> emit,
  ) {
    final newTerm = event.txtHocKy;

    final newState = state.copyWith(txtHocKy: newTerm);
    emit(newState);
  }

  void _onGetComment(GetComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(commentStatus: CommentStatus.loading));
    final data = await appFetchApiRepo.getComment(
      userKey: currentUserBloc.state.activeChild.user_key,
      txtDate: event.txtDate,
      // userKey: '0282810220108',
      // txtDate: '22-04-2024',
    );

    emit(state.copyWith(
      comment: data,
      endDate: event.endDate,
      startDate: event.startDate,
      commentStatus: CommentStatus.success,
    ));

    add(GetListReportStudent(learnYear: '', semester: 1));
  }

  void _onGetListReportStudent(
      GetListReportStudent event, Emitter<CommentState> emit) async {
    emit(state.copyWith(commentStatus: CommentStatus.loadingListReport));

    final data = await appFetchApiRepo.getListReportStudent(
      pupilId: currentUserBloc.state.activeChild.pupil_id,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      semester: event.semester,
      learnYear: event.learnYear.isEmpty
          ? CommentState._calculateYearRange()
          : event.learnYear,
    );

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(
      commentStatus: CommentStatus.successListReport,
      listReportStudent: data,
    ));
  }

  void _onGetReportStudent(
      GetReportStudent event, Emitter<CommentState> emit) async {
    emit(state.copyWith(commentStatus: CommentStatus.loadingReportStudent));
    final data = await appFetchApiRepo.getReportStudent(
      id: event.id,
      pupilId: currentUserBloc.state.activeChild.pupil_id,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
    );
    emit(state.copyWith(
        commentStatus: CommentStatus.successReportStudent,
        reportStudent: data));
  }
}

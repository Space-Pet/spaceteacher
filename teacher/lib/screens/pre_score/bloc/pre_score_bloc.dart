import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'pre_score_event.dart';
part 'pre_score_state.dart';

class PreScoreBloc extends Bloc<PreScoreEvent, PreScoreState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  PreScoreBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(PreScoreState(
          comment: Comment.fakeData(),
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          userData: TeacherDetail.empty(),
          armorial: Armorial.fakeData(),
        )) {
    on<GetListStudents>(_onGetListStudent);
    on<GetTeacherDetail>(_onGetTeacherDetail);
    on<GetArmorial>(_onGetArmorial);
    on<GetComment>(_onGetComment);
  }
  _onGetComment(
    GetComment event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetComment));
    final data = await appFetchApiRepo.getComment(
      userKey: event.userKey,
      txtDate: event.txtDate,
    );
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.successGetComment,
        comment: data,
        startDate: event.startDate,
        endDate: event.endDate));
  }

  _onGetArmorial(
    GetArmorial event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetArmorial));
    final data = await appFetchApiRepo.getArmorial();
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetArmorial,
      armorial: data,
    ));
  }

  _onGetTeacherDetail(
    GetTeacherDetail event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(
        state.copyWith(preScoreStatus: PreScoreStatus.loadingGetTeacherDetail));
    final teacherDetail = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetTeacherDetail,
      userData: teacherDetail,
    ));
  }

  _onGetListStudent(
    GetListStudents event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetListStudent));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: state.userData.lopChuNhiem.id,
    );
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetListStudent,
      listStudent: data,
    ));
  }
}

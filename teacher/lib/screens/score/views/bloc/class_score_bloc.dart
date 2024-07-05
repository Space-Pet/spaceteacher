import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/data/data.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'class_score_event.dart';
part 'class_score_state.dart';

class ClassScoreBloc extends Bloc<ClassScoreEvent, ClassScoreState> {
  ClassScoreBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(ClassScoreState(
          hanhKiemData: HanhKiemData(),
          primaryConduct: PrimaryConduct.empty(),
          formScoreESL: FormScoreESL.fakeData(),
          formMoet: FormMoet.empty(),
          markType: MarkTypeColumn.fakeData(),
          moetHighData: MoetHighData.empty(),
          phoneBookStudent: PhoneBookStudent.empty(),
          dataMoet: Data.empty(),
        )) {
    on<GetMoetPrimary>(_onGetMoet);
    on<ScoreSemesterListClass>(_onScoreSemesterListClass);
    on<GetStudentInputScore>(_onGetStudentInputScore);
    on<PostMOETPrimary>(_onPostMOETPrimary);
    on<UpdateTerm>(_onUpdateTerm);
    on<GetMoetHigh>(_onGetMoetHigh);
    on<GetMarkType>(_onGetMarkType);
    on<GetFormMoet>(_onGetFormMoet);
    on<PostMoetHigh>(_onPostMoetHigh);
    on<GetStudentInputScoreMoetHigh>(_onGetStudentInputScoreMoetHigh);
    on<GetFormScoreESL>(_onGetFormScoreESL);
    on<GetPrimaryConduct>(_onGetConduct);
    on<GetFormConduct>(_onGetFormConduct);
    on<PostPrimaryConduct>(_onPostPrimaryConduct);
    on<AddScoreConduct>(_onAddConduct);
    on<PostEslGpa>(_onPostEslGpa);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onPostEslGpa(
    PostEslGpa event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.laodingPostMOET));
    final data = await appFetchApiRepo.postEslGpa(
      classId: event.classId,
      semester: event.semester,
      learnYear: event.learnYear,
      dataESL: event.dataESL,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(
      state.copyWith(
        status: data['status'] == 'success'
            ? Status.successPostMOET
            : Status.failPostMOET,
        message: data['status'] == 'success' ? '' : data['message'],
      ),
    );
  }

  _onAddConduct(
    AddScoreConduct event,
    Emitter<ClassScoreState> emit,
  ) async {
    final updatedConductScore = [...?state.conductScore, ...event.data];
    emit(state.copyWith(conductScore: updatedConductScore));
  }

  _onPostPrimaryConduct(
    PostPrimaryConduct event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.laodingPostMOET));
    final data = await appFetchApiRepo.postPrimaryConduct(
      userKey: event.userKey,
      classId: event.classid,
      learnYear: event.learnYear,
      hocKy: event.hocKy,
      hocKyTih: event.hocKyTih,
      dataConduct: event.dataConduct,
    );
    emit(
      state.copyWith(
        status: data['status'] == 'Success'
            ? Status.successPostMOET
            : Status.failPostMOET,
        message: data['status'] == 'Success' ? '' : data['status_note'],
      ),
    );
  }

  _onGetFormConduct(
    GetFormConduct event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingFormConduct));
    final data = await appFetchApiRepo.getFormConduct();
    emit(state.copyWith(status: Status.successFormConduct, hanhKiemData: data));
  }

  _onGetConduct(
    GetPrimaryConduct event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingPrimaryConduct));
    final data = await appFetchApiRepo.getPrimaryConduct(
      userKey: event.userKey,
      txtHocKy: event.txtHocKy,
      txtYear: event.learnYaer,
      hkTihValue: event.hkTihValue,
    );
    emit(
      state.copyWith(
          status: Status.successPrimaryConduct, primaryConduct: data),
    );
  }

  _onGetFormScoreESL(
    GetFormScoreESL event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetFormESL));
    final data = await appFetchApiRepo.getFormScoreESL(
      classId: event.classId,
      subjectId: event.subjectId,
      scoreType: event.scoreType,
      semester: event.semester,
      learnYear: event.learnYear,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(status: Status.successGetFormESL, formScoreESL: data));
  }

  _onPostMoetHigh(
    PostMoetHigh event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.laodingPostMOET));
    final data = await appFetchApiRepo.postScoreMoetHighSchool(
      schoolId: currentUserBloc.state.user.school_id,
      subjectId: event.subjectId,
      classId: event.classId,
      semester: event.semester,
      data: event.data,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
      status: data['status'] == 'success'
          ? Status.successPostMOET
          : Status.failPostMOET,
      message: data['status'] == 'success' ? '' : data['message'],
    ));
  }

  _onGetFormMoet(
    GetFormMoet event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetMoet));
    final data = await appFetchApiRepo.getFormMoet(
      classId: event.classId,
      subjectId: event.subjectId,
      learnYear: event.learnYear,
      semester: event.semester,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(status: Status.successGetMoet, formMoet: data));
  }

  _onGetMarkType(
    GetMarkType event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingMarkType));
    final data = await appFetchApiRepo.getMarkType(
      subjectType: event.subjectType,
      classId: event.classId,
      capDaoTao: event.capDaoTao,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(status: Status.successMarkType, markType: data));
  }

  _onUpdateTerm(
    UpdateTerm event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(
      termType: event.semester,
      status: Status.updateTerm,
    ));
  }

  _onPostMOETPrimary(
    PostMOETPrimary event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.laodingPostMOET));
    final data = await appFetchApiRepo.postMoetPrimary(
      subjectId: event.subjectId,
      classId: event.classId,
      semester: event.semester,
      pupilId: event.pupilId,
      markType: event.markType,
      markValue: event.markValue,
      markNote: event.markNote,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(
      state.copyWith(
        status: data['status'] == 'success'
            ? Status.successPostMOET
            : Status.failPostMOET,
        message: data['message'],
      ),
    );
  }

  _onGetStudentInputScoreMoetHigh(
    GetStudentInputScoreMoetHigh event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetStudent));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: event.classId,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );

    emit(state.copyWith(status: Status.successGetStudent));
  }

  _onGetStudentInputScore(
    GetStudentInputScore event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetStudent));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: event.classId,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    PhoneBookStudent? filterData;
    int number = 0;
    if (currentUserBloc.state.user.cap_dao_tao.id == 'C_003') {
      for (var item in data) {
        number += 1;
        if (state.dataMoet.scoreData.isEmpty) {
          filterData = item;
          break;
        } else {
          bool isDuplicate =
              state.dataMoet.scoreData.any((e) => e.pupilId == item.pupilId);
          if (!isDuplicate) {
            filterData = item;
            break;
          }
        }
      }
    } else {
      for (var item in data) {
        number += 1;
        if (state.moetHighData.scoreData.isEmpty) {
          filterData = item;
          break;
        } else {
          bool isDulicate = state.moetHighData.scoreData
              .any((e) => e.pupilId == item.pupilId);
          if (!isDulicate) {
            filterData = item;
            break;
          }
        }
      }
    }

    String sum = '$number/${data.length}';

    emit(state.copyWith(
      numberInputScore: sum,
      status: Status.successGetStudent,
      phoneBookStudent: filterData,
    ));
  }

  _onGetMoetHigh(
    GetMoetHigh event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetMoet));
    final data = await appFetchApiRepo.getTeachingClassMoetHigh(
      subjectId: event.subjectId,
      classId: event.classId,
      semester: event.semester,
      learnYear: event.learnYear,
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id.toString(),
    );
    emit(state.copyWith(status: Status.successGetMoet, moetHighScore: data));
  }

  _onGetMoet(
    GetMoetPrimary event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetMoet));
    final data = await appFetchApiRepo.getTeachingClassMoetPrimary(
      capDaoTao: event.capDaoTao,
      subjectId: event.subjectId,
      classId: event.classId,
      semester: event.semester,
      learnYear: event.learnYear,
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id.toString(),
    );
    emit(state.copyWith(
      status: Status.successGetMoet,
      dataMoet: data,
    ));
  }

  _onScoreSemesterListClass(
    ScoreSemesterListClass event,
    Emitter<ClassScoreState> emit,
  ) async {
    emit(state.copyWith(status: Status.loadingGetSemester));
    final data = await appFetchApiRepo.getSemester(
      subjectType: event.subjectType,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
      capDaoTao: event.capDaoTao,
    );
    emit(state.copyWith(
        status: Status.successGetSemester, semesterTabTeaching: data));
  }
}

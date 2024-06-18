import 'dart:ffi';

import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  NutritionBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(
          NutritionState(
            userData: TeacherDetail.empty(),
          ),
        ) {
    on<HomeFetchProfileData>(_onFetchTeacherDetail);
    add(HomeFetchProfileData());
    on<GetListStudent>(_onGetListStudent);
    on<GetNutrition>(_onGetNutrition);
    on<SelectDateNutri>(_onSelectDate);
    on<PostNutritionUpdate>(_onPostUpdate);
  }

  _onPostUpdate(
    PostNutritionUpdate event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(nutritionStatus: NutritionStatus.loadingPostUpdate));
    final data = await appFetchApiRepo.postNutritionHealth(
      pupilId: event.pupilId,
      learnYear: event.learnYear,
      txtMonth: event.txtMonth,
      typeHeight: event.typeHeight,
      weight: event.weight,
      height: event.height,
      bmi: event.bmi,
      distribute: event.distribute,
    );
    emit(state.copyWith(
      nutritionStatus: data['status'] == 'Success'
          ? NutritionStatus.successPostUpdate
          : NutritionStatus.failPost,
      statusNote: data['status_note'],
    ));
  }

  _onSelectDate(
    SelectDateNutri event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(selectDate: event.selectDate));
  }

  _onGetNutrition(
    GetNutrition event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(nutritionStatus: NutritionStatus.loadingGetNutrition));
    final data = await appFetchApiRepo.getNutrition(userKey: event.userKey);
    final mmyyyy = event.date.mmyyyy;
    final myyyy = event.date.myyyy;
    DataNutrition? newData;
    for (var item in data.dataNutrition) {
      if (myyyy == item.month || mmyyyy == item.month) {
        newData = item;
        break;
      }
    }
    emit(state.copyWith(
      nutritionStatus: NutritionStatus.successGetNutrition,
      nutrition: newData,
    ));
  }

  _onGetListStudent(
    GetListStudent event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(nutritionStatus: NutritionStatus.loading));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: state.userData.lopChuNhiem.id,
    );

    emit(state.copyWith(
      nutritionStatus: NutritionStatus.success,
      listStudent: data,
    ));
  }

  void _onFetchTeacherDetail(
    HomeFetchProfileData event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(nutritionStatus: NutritionStatus.loadingUserData));
    final teacherDetail = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());

    emit(
      state.copyWith(
        nutritionStatus: NutritionStatus.successUserData,
        userData: teacherDetail,
      ),
    );
  }
}

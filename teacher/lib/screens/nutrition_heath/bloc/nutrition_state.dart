part of 'nutrition_bloc.dart';

enum NutritionStatus {
  init,
  loading,
  success,
  error,
  loadingUserData,
  successUserData,
  loadingGetNutrition,
  successGetNutrition,
  loadingPostUpdate,
  successPostUpdate,
  failPost,
}

class NutritionState extends Equatable {
  const NutritionState({
    this.nutrition,
    this.nutritionStatus = NutritionStatus.init,
    required this.userData,
    this.listStudent = const [],
    this.selectDate,
    this.statusNote = '',
  });
  final NutritionStatus nutritionStatus;
  final DataNutrition? nutrition;
  final TeacherDetail userData;
  final List<PhoneBookStudent> listStudent;
  final DateTime? selectDate;
  final String statusNote;

  @override
  List<Object?> get props => [
        nutrition,
        nutritionStatus,
        selectDate,
        listStudent,
        statusNote,
      ];
  NutritionState copyWith({
    String? statusNote,
    List<PhoneBookStudent>? listStudent,
    DateTime? selectDate,
    TeacherDetail? userData,
    DataNutrition? nutrition,
    NutritionStatus? nutritionStatus,
  }) {
    return NutritionState(
        statusNote: statusNote ?? this.statusNote,
        selectDate: selectDate ?? this.selectDate,
        listStudent: listStudent ?? this.listStudent,
        userData: userData ?? this.userData,
        nutrition: nutrition ?? this.nutrition,
        nutritionStatus: nutritionStatus ?? this.nutritionStatus);
  }
}

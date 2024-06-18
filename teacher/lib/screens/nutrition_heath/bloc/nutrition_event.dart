part of 'nutrition_bloc.dart';

sealed class NutritionEvent {}

class GetNutrition extends NutritionEvent {
  final String userKey;
  final DateTime date;
  GetNutrition({
    required this.date,
    required this.userKey,
  });
}

class HomeFetchProfileData extends NutritionEvent {
  HomeFetchProfileData();
}

class GetListStudent extends NutritionEvent {}

class SelectDateNutri extends NutritionEvent {
  final DateTime selectDate;
  SelectDateNutri({
    required this.selectDate,
  });
}

class PostNutritionUpdate extends NutritionEvent {
  final int pupilId;
  final DateTime learnYear;
  final int txtMonth;
  final String typeHeight;
  final String height;
  final String weight;
  final double bmi;
  final String distribute;
  PostNutritionUpdate({
    required this.bmi,
    required this.distribute,
    required this.height,
    required this.learnYear,
    required this.pupilId,
    required this.txtMonth,
    required this.typeHeight,
    required this.weight,
  });
}

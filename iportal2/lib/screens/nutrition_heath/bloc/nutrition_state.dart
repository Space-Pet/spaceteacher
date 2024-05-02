part of 'nutrition_bloc.dart';

enum NutritionStatus { init, loading, success, error }

class NutritionState extends Equatable {
  const NutritionState(
      {this.nutrition, this.nutritionStatus = NutritionStatus.init, required this.user});
  final NutritionStatus nutritionStatus;
  final Nutrition? nutrition;
  final ProfileInfo user;
  @override
  List<Object?> get props => [nutrition, nutritionStatus];
  NutritionState copyWith({
    Nutrition? nutrition,
    NutritionStatus? nutritionStatus,
    ProfileInfo? user
  }) {
    return NutritionState(
      user: user ?? this.user,
        nutrition: nutrition ?? this.nutrition,
        nutritionStatus: nutritionStatus ?? this.nutritionStatus);
  }
}

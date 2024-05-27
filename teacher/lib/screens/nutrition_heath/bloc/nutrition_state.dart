part of 'nutrition_bloc.dart';

enum NutritionStatus { init, loading, success, error }

class NutritionState extends Equatable {
  const NutritionState(
      {this.nutrition, this.nutritionStatus = NutritionStatus.init});
  final NutritionStatus nutritionStatus;
  final Nutrition? nutrition;

  @override
  List<Object?> get props => [nutrition, nutritionStatus];
  NutritionState copyWith({
    Nutrition? nutrition,
    NutritionStatus? nutritionStatus,
  }) {
    return NutritionState(
        nutrition: nutrition ?? this.nutrition,
        nutritionStatus: nutritionStatus ?? this.nutritionStatus);
  }
}

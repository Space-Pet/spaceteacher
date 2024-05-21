import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  NutritionBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(NutritionState(user: userRepository.notSignedIn())) {
    on<GetNutrition>(_onGetNutrition);
    add(GetNutrition());
  }
  _onGetNutrition(GetNutrition event, Emitter<NutritionState> emit) async {
    try {
      emit(state.copyWith(nutritionStatus: NutritionStatus.loading));
      final data = await appFetchApiRepo.getNutrition(
          userKey: currentUserBloc.state.user.user_key);
      emit(state.copyWith(
          nutritionStatus: NutritionStatus.success, nutrition: data));
    } catch (e) {
      emit(state.copyWith(nutritionStatus: NutritionStatus.error));
    }
  }
}
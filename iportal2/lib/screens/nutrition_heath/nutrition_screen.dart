import 'package:core/core.dart';
import 'package:core/resources/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/nutrition_heath/bloc/nutrition_bloc.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/card_nutrition.dart';
import 'package:repository/repository.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});
  static const routeName = '/nutrition-health';
  @override
  State<NutritionScreen> createState() => NutritionScreenState();
}

class NutritionScreenState extends State<NutritionScreen> {
  int? expandedIndex;
  void _handleExpansion(int index) {
    if (index == expandedIndex) {
      setState(() {
        expandedIndex = null;
      });
    } else {
      setState(() {
        expandedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => NutritionBloc(
          userRepository: context.read<UserRepository>(),
          appFetchApiRepo: context.read<AppFetchApiRepository>(),
          currentUserBloc: context.read<CurrentUserBloc>()),
      child: BlocBuilder<NutritionBloc, NutritionState>(
        builder: (context, state) {
          final isLoading = state.nutritionStatus == NutritionStatus.loading;
          final nutrition = state.nutrition;
          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Sức khỏe dinh dưỡng',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop20,
                    ),
                    child: AppSkeleton(
                      isLoading: isLoading,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppRadius.roundedTop28,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                              child: Text(
                                nutrition?.statusNote ?? '',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: AppTextStyles.semiBold16(
                                    color: AppColors.brand600),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    ...List.generate(
                                        nutrition?.dataNutrition.length ?? 0,
                                        (index) => CardNutrition(
                                            isExpanded: expandedIndex == index,
                                            index: index,
                                            onExpansionChanged: () =>
                                                _handleExpansion(index),
                                            nutritionItem: nutrition!
                                                .dataNutrition.reversed
                                                .toList()[index],
                                            lastIndex: index ==
                                                nutrition.dataNutrition.length -
                                                    1))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

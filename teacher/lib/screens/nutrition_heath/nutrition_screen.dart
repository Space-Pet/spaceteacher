import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/nutrition_heath/bloc/nutrition_bloc.dart';
import 'package:teacher/screens/nutrition_heath/widget/nutrition_card/card_nutrition.dart';
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
    double calculatedHeight = screenHeight / 1.4;
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
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: AppSkeleton(
                      isLoading: isLoading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: AppRadius.roundedTop28,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SelectChild(),
                                      Text(
                                        nutrition?.statusNote ?? '',
                                        style: AppTextStyles.semiBold16(
                                            color: AppColors.brand600),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: calculatedHeight,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                    color: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.blueGray100),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: AppColors.gray9000c,
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                            nutrition?.dataNutrition.length ??
                                                0,
                                            (index) => CardNutrition(
                                                isExpanded:
                                                    expandedIndex == index,
                                                index: index,
                                                onExpansionChanged: () =>
                                                    _handleExpansion(index),
                                                nutritionItem: nutrition!
                                                    .dataNutrition.reversed
                                                    .toList()[index],
                                                lastIndex: nutrition
                                                        .dataNutrition.length -
                                                    1))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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

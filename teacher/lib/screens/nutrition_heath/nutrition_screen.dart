import 'package:core/core.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/bus/widgets/select_date.dart';
import 'package:teacher/screens/nutrition_heath/add_student.dart';
import 'package:teacher/screens/nutrition_heath/bloc/nutrition_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/screens/nutrition_heath/edit_nutrition.dart';
import 'package:teacher/screens/nutrition_heath/widget/select_date.dart';

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
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocListener<NutritionBloc, NutritionState>(
        listener: (context, state) {
          if (state.nutritionStatus == NutritionStatus.successUserData) {
            context.read<NutritionBloc>().add(GetListStudent());
          }
        },
        child: BlocBuilder<NutritionBloc, NutritionState>(
          builder: (context, state) {
            final isLoading = state.nutritionStatus == NutritionStatus.loading;
            final listStudent = state.listStudent;
            final date = state.selectDate;
            return BackGroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenAppBar(
                    title: 'Sức khoẻ dinh dưỡng',
                    canGoback: true,
                    onBack: () {
                      context.pop();
                    },
                    iconRight: Assets.icons.addMessage,
                    onRight: () {
                      context.push(AddStudentNutritionScreen(
                        phoneBookStudent: listStudent,
                      ));
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
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
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
                                          Text(
                                            'Sức khoẻ dinh dưỡng lớp Kindy 3',
                                            style: AppTextStyles.semiBold16(
                                                color: AppColors.brand600),
                                          ),
                                          SelectDateNutrition(
                                            onDatePicked: (date) {
                                              print('date: $date');
                                              context.read<NutritionBloc>().add(
                                                  SelectDateNutri(
                                                      selectDate: date));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: calculatedHeight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: ShapeDecoration(
                                        color: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: AppColors.blueGray100),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: AppColors.gray9000c,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: listStudent.length,
                                        itemBuilder: (context, index) {
                                          final item = listStudent[index];
                                          return GestureDetector(
                                            onTap: () {
                                              context.push(EditNutritionScreen(
                                                phoneBookStudent: item,
                                                date: date ?? DateTime.now(),
                                              ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(item
                                                            .urlImage.mobile),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.fullName,
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color: AppColors
                                                                .brand600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          item.pupilId
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color: AppColors
                                                                .gray400,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

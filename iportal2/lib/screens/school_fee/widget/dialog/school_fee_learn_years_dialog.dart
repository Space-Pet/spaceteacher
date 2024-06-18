import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_status.dart';

class LearnYearWidgetButton extends StatefulWidget {
  const LearnYearWidgetButton({super.key});

  @override
  State<LearnYearWidgetButton> createState() => _LearnYearWidgetButtonState();
}

class _LearnYearWidgetButtonState extends State<LearnYearWidgetButton> {
  String currentYearTXT = '';
  LearnYearPayment? currentYear;

  List<LearnYearPayment> learnYears = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SchoolFeeBloc>(),
      child: BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
        listener: (context, state) {
          if (state.schoolFeeGetLearnYearsStatus ==
              SchoolFeeGetLearnYearsStatus.loaded) {
            learnYears = state.learnYears ?? [];
            if (learnYears.isNotEmpty) {
              currentYear = learnYears.firstWhere(
                (e) => e.currentLearnYear == 1,
                orElse: () => learnYears.first,
              );
              currentYearTXT = currentYear?.learnYear ?? '';
            }
          } else if (state.schoolFeeGetLearnYearsStatus ==
              SchoolFeeGetLearnYearsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Lỗi khi lấy dữ liệu năm học'),
              ),
            );
          } else if (state.schoolFeeGetLearnYearsStatus ==
              SchoolFeeGetLearnYearsStatus.updated) {
            currentYear = state.currentYearState;
            currentYearTXT = currentYear?.learnYear ?? '';
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      alignment: Alignment.center,
                      insetPadding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Chọn năm học', style: AppTextStyles.bold16()),
                          Column(
                            children: List.generate(
                              learnYears.length,
                              (index) {
                                return ListTile(
                                    title:
                                        Text(learnYears[index].learnYear ?? ''),
                                    onTap: () {
                                      context.read<SchoolFeeBloc>().add(
                                          UpdateCurrentYearEvent(
                                              learnYears[index]));
                                      setState(() {
                                        currentYearTXT =
                                            learnYears[index].learnYear ?? '';
                                        currentYear = learnYears[index];
                                      });
                                      Navigator.of(ctx).pop(true);
                                    },
                                    trailing: currentYearTXT ==
                                            learnYears[index].learnYear
                                        ? const Icon(
                                            Icons.check,
                                            color: AppColors.brand500,
                                          )
                                        : null);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).then(
                  (res) {
                    if (res != null && res == true) {
                      context.read<SchoolFeeBloc>().add(FetchSchoolFee(
                            learnYear: currentYear?.learnYear ?? '',
                          ));
                      context.read<SchoolFeeBloc>().add(FetchSchoolFeeHistory(
                            learnYear: currentYear?.learnYear ?? '',
                          ));
                    }
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      currentYearTXT,
                      style: AppTextStyles.bold14(color: AppColors.white),
                    ),
                    SvgPicture.asset(
                      Assets.icons.chevronDown,
                      color: AppColors.white,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

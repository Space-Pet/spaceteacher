import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_status.dart';

class FeePlanLearnYearButton extends StatefulWidget {
  const FeePlanLearnYearButton({super.key});

  @override
  State<FeePlanLearnYearButton> createState() => _FeePlanLearnYearButtonState();
}

class _FeePlanLearnYearButtonState extends State<FeePlanLearnYearButton> {
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
      value: context.read<FeePlanBloc>(),
      child: BlocConsumer<FeePlanBloc, FeePlanState>(
        listener: (context, state) {
          if (state.learnYearsStatus ==
              FeePlanLearnYearsStatus.loaded) {
            learnYears = state.learnYears ?? [];
            if (learnYears.isNotEmpty) {
              currentYear = learnYears.firstWhere(
                (e) => e.currentLearnYear == 1,
                orElse: () => learnYears.first,
              );
              currentYearTXT = currentYear?.learnYear ?? '';
            }
          } else if (state.learnYearsStatus ==
              FeePlanLearnYearsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Lỗi khi lấy dữ liệu năm học'),
              ),
            );
          } else if (state.learnYearsStatus ==
              FeePlanLearnYearsStatus.updated) {
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
                                      context.read<FeePlanBloc>().add(
                                          UpdateCurrentYear(
                                           currentYearState:   learnYears[index]),);
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
                      context.read<FeePlanBloc>().add(GetListFee(
                            learnYear: currentYear?.learnYear ?? '',
                          ));
                      context.read<FeePlanBloc>().add(GetFeeRequested(
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

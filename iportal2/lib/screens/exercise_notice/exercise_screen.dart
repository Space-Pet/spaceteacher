import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/screens/exercise_notice/bloc/exercise_bloc.dart';
import 'package:iportal2/screens/exercise_notice/widgets/excersise_note/exercise_note_list.dart';
import 'package:iportal2/screens/exercise_notice/widgets/select_popup_sheet/select_option_button.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

enum SubjectType {
  all,
  math,
  physics,
  chemistry,
  english,
}

extension SubjectTypeX on SubjectType {
  String text() {
    switch (this) {
      case SubjectType.all:
        return "Tất cả các môn";
      case SubjectType.math:
        return "Toán";
      case SubjectType.physics:
        return "Vật lý";
      case SubjectType.chemistry:
        return "Hóa học";
      case SubjectType.english:
        return "Tiếng Anh";
      default:
        return "Tất cả các môn";
    }
  }
}

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    DateFormat formatDateDrill = DateFormat("dd-MM-yyyy", 'vi_VN');

    return BlocProvider(
      create: (context) => ExerciseBloc(
        todayString: formatDateDrill.format(DateTime.now()),
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child:
          BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
        final exerciseList = state.exerciseDataList;
        return ExerciseScreenView(exerciseList: exerciseList);
      }),
    );
  }
}

class ExerciseScreenView extends StatefulWidget {
  const ExerciseScreenView({
    super.key,
    required this.exerciseList,
  });
  final ExerciseData exerciseList;
  static const routeName = '/exercise';

  @override
  State<ExerciseScreenView> createState() => ExerciseScreenViewState();
}

class ExerciseScreenViewState extends State<ExerciseScreenView> {
  String selectedSubject = SubjectType.all.text();

  @override
  void initState() {
    super.initState();
    selectedSubject = SubjectType.all.text();
  }

  void handleSelectedOptionChanged(String newOption) {
    setState(() {
      selectedSubject = newOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseBloc = context.read<ExerciseBloc>();

    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Sổ báo bài',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SelectDate(
                    onDatePicked: (date) {
                      exerciseBloc.add(ExerciseSelectDate(datePicked: date));
                    },
                  ),
                  const SizedBox(height: 16),
                  SelectSubject(
                      optionList: widget.exerciseList.getSubjectList(),
                      onSelectedOptionChanged: handleSelectedOptionChanged),
                  const SizedBox(height: 16),
                  Expanded(
                    child: widget.exerciseList.exerciseDataList.isEmpty
                        ? const EmptyScreen(text: 'Sổ báo bài trống')
                        : SingleChildScrollView(
                            child: ExerciseItemList(
                              selectedSubject: selectedSubject,
                              exercise: widget.exerciseList.exerciseDataList,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectSubject extends StatefulWidget {
  const SelectSubject({
    super.key,
    required this.onSelectedOptionChanged,
    required this.optionList,
  });
  final Function(String) onSelectedOptionChanged;
  final List<String> optionList;

  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/exercise.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 6),
              Text(
                'Chọn môn',
                style: AppTextStyles.semiBold16(
                  color: AppColors.blueGray800,
                ),
              ),
            ],
          ),
          SelectPopupSheet(
            optionList: widget.optionList,
            onSelectedOptionChanged: widget.onSelectedOptionChanged,
          )
        ],
      ),
    );
  }
}

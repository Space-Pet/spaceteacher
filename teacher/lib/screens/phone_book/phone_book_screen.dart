import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/phone_book/bloc/phone_book_bloc.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';
import 'package:teacher/screens/phone_book/widget/phone_book_bottom_sheet.dart';
import 'package:teacher/screens/phone_book/widget/tab_bar_phone_book.dart';
import 'package:repository/repository.dart';

class PhoneBookScreen extends StatelessWidget {
  const PhoneBookScreen({super.key});
  static const routeName = '/phone_book';
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final phoneBookBloc = PhoneBookBloc(
      appFetchApiRepo: appFetchApiRepository,
      appFetchApiRepository: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    phoneBookBloc.add(GetListClass());
    phoneBookBloc.add(GetPhoneBookStudent());
    phoneBookBloc.add(GetPhoneBookTeacher());
    return BlocProvider.value(
      value: phoneBookBloc,
      child: PhoneBookView(
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
    );
  }
}

class PhoneBookView extends StatefulWidget {
  const PhoneBookView({super.key, required this.currentUserBloc});
  final CurrentUserBloc currentUserBloc;

  @override
  State<PhoneBookView> createState() => _PhoneBookViewState();
}

class _PhoneBookViewState extends State<PhoneBookView> {
  String _searchKey = '';

  @override
  void initState() {
    super.initState();
  }

  void onParentTap(value) {
    ShowBottomSheetPhone.show(
      context,
      onTap: () {},
      phoneBook: value,
      index: 1,
    );
  }

  void onStudentTap(value) {
    ShowBottomSheetPhone.show(
      context,
      onTap: () {},
      phoneBook: value,
      index: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneBookBloc, PhoneBookState>(
        builder: (context, state) {
      final isLoading = state.phoneBookStatus == PhoneBookStatus.loading;
      // final phoneBookStudent = state.phoneBookStudent;
      // final phoneBookTeacher = state.phoneBookParent;
      final phoneBookParent = mockPhoneBookStudent;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              BlocBuilder<PhoneBookBloc, PhoneBookState>(
                builder: (context, state) {
                  return PhoneBookAppBar(
                    isLoading:
                        state.classTeacherStatus == ApiCallStatus.loading,
                    optionList:
                        state.classTeacher.map((e) => e.className).toList(),
                    selectedOption: state.classTeacher.isEmpty
                        ? ''
                        : state.classTeacher[0].className,
                    onUpdateOption: (value) {},
                  );
                },
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lightBlue,
                        AppColors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TitleAndInputText(
                          hintText: 'Tìm kiếm',
                          onChanged: (value) {
                            setState(() {
                              _searchKey = value;
                            });
                          },
                          prefixIcon: Assets.images.search.image(),
                        ),
                      ),
                      Flexible(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: TabBarPhoneBook(
                            currentUserBloc: context.read<CurrentUserBloc>(),
                            phoneBookStudent: state.phoneBookStudent,
                            phoneBookTeacher: state.phoneBookTeacher,
                            phoneBookParent: state.phoneBookParent,
                            onParentTap: onParentTap,
                            onStudentTap: onStudentTap,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class PhoneBookAppBar extends StatelessWidget {
  const PhoneBookAppBar({
    super.key,
    this.isLoading = true,
    required this.optionList,
    required this.selectedOption,
    required this.onUpdateOption,
  });

  final bool isLoading;
  final List<String> optionList;
  final String selectedOption;
  final void Function(String value) onUpdateOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: ScreenAppBar(
            title: 'Danh bạ',
          ),
        ),
        isLoading
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        titlePadding: EdgeInsets.zero,
                        backgroundColor: AppColors.white,
                        title: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Lớp học',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 1; i <= optionList.length; i++)
                              ListTile(
                                title: Text(
                                  optionList[i - 1],
                                ),
                                trailing: Radio(
                                  value: i,
                                  groupValue: 1,
                                  onChanged: (_) {},
                                ),
                              ),
                            // for (int i = 1; i <= 3; i++)
                            //   ListTile(
                            //     title: Text(
                            //       'Lớp $i (22)',
                            //     ),
                            //     trailing: Radio(
                            //       value: i,
                            //       groupValue: 1,
                            //       onChanged: (_) {},
                            //     ),
                            //   ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 16,
                    top: 24,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppColors.white,
                  ),
                ),
              )
      ],
    );
  }
}

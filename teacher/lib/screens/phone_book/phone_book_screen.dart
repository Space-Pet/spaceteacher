import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/message/screens/conversation_detail.dart';
import 'package:teacher/screens/phone_book/bloc/phone_book_bloc.dart';
import 'package:teacher/screens/phone_book/widget/phone_book_bottom_sheet.dart';
import 'package:teacher/screens/phone_book/widget/tab_bar_phone_book.dart';

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

    return BlocProvider.value(
      value: phoneBookBloc,
      child: const PhoneBookView(),
    );
  }
}

class PhoneBookView extends StatefulWidget {
  const PhoneBookView({super.key});

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

  }

  void onStudentTap(PhoneBookStudent studentInfo) {
    mainNavKey.currentContext!.pushNamed(
      routeName: ConversationDetail.routeName,
      arguments: {
        'conversationId': '',
        'recipientId': studentInfo.userId.toString(),
        'isGetById': true,
        'fullName': studentInfo.fullName,
        'urlImage': studentInfo.urlImage.mobile,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneBookBloc, PhoneBookState>(
        builder: (context, state) {
      final isLoading = state.phoneBookStatus == PhoneBookStatus.loading;
      final listClass = state.classTeacher;

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
                    optionList: listClass
                        .map((e) => 'Lớp ${e.gradeTitle}${e.className}')
                        .toList(),
                    selectedOption: listClass.isEmpty
                        ? ''
                        : 'Lớp ${listClass[0].gradeTitle}${listClass[0].className}',
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
                      TitleAndInputText(
                        hintText: 'Tìm kiếm',
                        onChanged: (value) {
                          setState(() {
                            _searchKey = value;
                          });
                        },
                        prefixIcon: Assets.images.search.image(),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: TabBarPhoneBook(
                            phoneBookStudent: state.phoneBookStudent,
                            phoneBookTeacher: state.phoneBookTeacher,
                            phoneBookParent: state.phoneBookParent,
                            onParentTap: onParentTap,
                            onStudentTap: onStudentTap,
                            searchKeyword: _searchKey,
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
    required this.optionList,
    required this.selectedOption,
    required this.onUpdateOption,
  });

  final List<String> optionList;
  final String selectedOption;
  final void Function(String value) onUpdateOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ScreenAppBar(
              title: 'Danh bạ',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32, right: 16),
            child: FilterItem(
              selectedOption: selectedOption,
              onUpdateOption: (value) {},
              title: 'Chọn lớp',
              options: optionList,
              isTransparentStyle: true,
            ),
          )
        ],
      ),
    );
  }
}

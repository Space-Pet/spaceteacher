import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/phone_book/bloc/phone_book_bloc.dart';
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
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
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

class PhoneBookView extends StatelessWidget {
  const PhoneBookView({super.key, required this.currentUserBloc});
  final CurrentUserBloc currentUserBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneBookBloc, PhoneBookState>(
        builder: (context, state) {
      final isLoading = state.phoneBookStatus == PhoneBookStatus.loading;
      final phoneBookStudent = state.phoneBookStudent;
      final phoneBookTeacher = state.phoneBookTeacher;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Danh bạ',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      Flexible(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: TabBarPhoneBook(
                            currentUserBloc: currentUserBloc,
                            phoneBookTeacher: phoneBookTeacher,
                            phoneBookStudent: phoneBookStudent,
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

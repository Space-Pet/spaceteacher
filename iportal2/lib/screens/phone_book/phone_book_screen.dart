import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/phone_book/bloc/phone_book_bloc.dart';
import 'package:iportal2/screens/phone_book/widget/tab_bar_phone_book.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';


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
      final user = state.user;
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
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 12),
                      //   child: SelectChild(),
                      // ),
                      // const SizedBox(height: 8),
                      Flexible(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          skeleton: SizedBox(
                            height: 500,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: 5,
                              itemBuilder: (context, index) => Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: index == 4
                                        ? BorderSide.none
                                        : const BorderSide(
                                            color: AppColors.gray300),
                                  ),
                                ),
                                child: SkeletonItem(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                lineStyle: SkeletonLineStyle(
                                                  randomLength: true,
                                                  height: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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

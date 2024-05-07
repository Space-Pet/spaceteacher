import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/phone_book/model/list_phone_book.dart';
import 'package:teacher/src/screens/phone_book/widget/app_bar_phone_book.dart';
import 'package:teacher/src/screens/phone_book/widget/tab_bar_phone_book.dart';
// import 'package:teacher/src/utils/extension_context.dart';
import 'package:skeletons/skeletons.dart';
import 'package:teacher/src/utils/extension_context.dart';

class PhoneBookScreen extends StatelessWidget {
  const PhoneBookScreen({super.key});
  static const routeName = '/phone_book';
  @override
  Widget build(BuildContext context) {
    // final userRepository = context.read<UserRepository>();
    // final appFetchApiRepository = context.read<AppFetchApiRepository>();
    // final phoneBookBloc = PhoneBookBloc(
    //     appFetchApiRepo: appFetchApiRepository,
    //     currentUserBloc: context.read<CurrentUserBloc>(),
    //     userRepository: userRepository);
    // phoneBookBloc.add(GetPhoneBookStudent());
    // phoneBookBloc.add(GetPhoneBookTeacher());
    // return BlocProvider.value(
    //   value: phoneBookBloc,
    //   child: PhoneBookView(
    //     currentUserBloc: context.read<CurrentUserBloc>(),
    //   ),
    // );
    return const PhoneBookView();
  }
}

class PhoneBookView extends StatelessWidget {
  const PhoneBookView({super.key});
  // final CurrentUserBloc currentUserBloc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BackGroundContainer(
        child: Column(
          children: [
            ScreenAppBar(
              title: 'danh bạ',
              onBack: () {
                context.pop();
              },
              canGoback: true,
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
                        isLoading: false,
                        skeleton: SizedBox(
                          height: 500,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: 5,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                          // currentUserBloc: currentUserBloc,
                          phoneBookTeacher: phoneBookTeacher,
                          phoneBookStudent: phoneBook,
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
  }
}
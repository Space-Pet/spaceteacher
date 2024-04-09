import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/children_model.dart';
import 'package:teacher/model/user_info.dart';

import 'package:teacher/repository/student_repository/student_repository.dart';

import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/profile/bloc/profile_bloc.dart';
import 'package:teacher/src/screens/profile/widget/profile_app_bar.dart';
import 'package:teacher/src/screens/profile/widget/tab_bar_parent.dart';
import 'package:teacher/src/screens/profile/widget/tab_bar_student.dart';
import 'package:teacher/src/utils/extension_context.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.userInfo, super.key});
  static const routeName = '/profile';

  final UserInfo userInfo;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int role = 0;
  final bloc =
      ProfileBloc(studentRepository: Injection.get<StudentRepository>());

  @override
  void initState() {
    bloc.add(ProfileGetProfilePupil(pupilId: widget.userInfo.pupilId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == ProfileStatus.loaded) {
          return Scaffold(
            body: BackGroundContainer(
              child: Column(
                children: [
                  ProfileAppBar(
                    studentModel: state.studentModel,
                    childrenModel: widget.userInfo.children ?? ChildrenModel(),
                    onBack: () {
                      context.pop(result: true);
                    },
                    role: role,
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image(
                              image: widget.userInfo.brandLogo(),
                              height: 100,
                            ),
                          ),
                          if (role == 0)
                            TabBarStudent(
                              studentModel: state.studentModel,
                            ),
                          if (role == 1) const TabBarParent()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text(state.errorString ?? 'Error'),
          );
        }
      },
    );
  }
}

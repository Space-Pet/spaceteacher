import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/authentication/domain/bloc/login_bloc.dart';

class TeacherChooseSchool extends StatelessWidget {
  const TeacherChooseSchool({
    super.key,
    required this.loginBloc,
  });

  final LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final listSchool = state.listSchoolTeacher;

          final listChilderW = List.generate(listSchool.length, (index) {
            final school = listSchool[index];
            return InkWell(
              onTap: () {
                context.pop();
                context.read<LoginBloc>().add(LoginWithSchool(
                      teacherId: school.teacherId,
                    ));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: index == listSchool.length - 1
                          ? Colors.transparent
                          : AppColors.gray100,
                    ),
                  ),
                ),
                child: Text(
                  school.schoolName,
                  style: AppTextStyles.semiBold16(color: AppColors.black24),
                ),
              ),
            );
          });

          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Chọn trường để đăng nhập',
                  style: AppTextStyles.semiBold18(color: AppColors.brand600),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listChilderW,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

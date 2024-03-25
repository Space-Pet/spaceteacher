import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:iportal2/screens/student_score_screen_pre/student_score_screen_pre.dart';

class StudentScoreScreenMain extends StatelessWidget {
  const StudentScoreScreenMain({super.key});
  static const routeName = '/student-score';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
      if (state.user.isKinderGarten()) {
        return const StudentScoreScreenPre();
      } else {
        return const StudentScoreScreen();
      }
    });
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future(() async =>
            await UserManager.instance.getUser(Injection.get<Settings>())),
        builder: (ctx, snap) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${snap.data?.name}"),
                Text("${snap.data?.schoolBrand}"),
                Text("${snap.data?.schoolName}"),
                Text("${snap.data?.parentName}"),
                ElevatedButton(
                  onPressed: () async {
                    UserManager.instance
                        .logout(setting: Injection.get<Settings>());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteBackground),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:core/presentation/screens/domain/domain_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/env_config_override.dart';
import 'package:iportal2/app_config/router_configuration.dart';

import '../login/view/login_screen.dart';

class DomainScreen extends StatelessWidget {
  const DomainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (EnvironmentConfigOverride.baseUrl.isNotEmpty) {
        context.push(const LoginScreen());
      } else {
        DomainSaver().getDomain().then((value) {
          EnvironmentConfigOverride.baseURL = value;
          if (EnvironmentConfigOverride.baseUrl.isNotEmpty) {
            context.push(const LoginScreen());
          }
        });
      }
    });
    return CDomainScreen(
      onDomainSaved: ((isSaved, domain) {
        if (isSaved) {
          EnvironmentConfigOverride.baseURL = domain;
          context.push(const LoginScreen());
        } else {
          Fluttertoast.showToast(
            msg: domain,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }),
    );
  }
}

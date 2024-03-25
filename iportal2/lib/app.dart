import 'package:core/common/constants/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/splash/loading_screen.dart';
import 'package:iportal2/resources/app_size.dart';
import 'package:repository/repository.dart';

final mainNavKey = GlobalKey<NavigatorState>();

class IPortal2App extends StatelessWidget {
  const IPortal2App({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.jobRepository,
  });

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final JobRepository jobRepository;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authRepository),
          RepositoryProvider.value(value: userRepository),
          RepositoryProvider.value(value: jobRepository),
          RepositoryProvider.value(value: userRepository),
        ],
        child: BlocProvider(
          create: (context) => CurrentUserBloc(
            userRepository: context.read<UserRepository>(),
          ),
          child: BlocListener<CurrentUserBloc, CurrentUserState>(
            listenWhen: (previous, current) => previous.user != current.user,
            listener: (context, state) {},
            child:  MaterialApp(
              navigatorKey: mainNavKey,
              debugShowCheckedModeBanner: false,
              locale: AppLocale.vi,
              localizationsDelegates: const[
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [AppLocale.vi, AppLocale.en],
              initialRoute: LoadingScreen.routeName,
              onGenerateRoute: CustomRouter.onGenerateRoute,
            ),
          ),
        ),
      );
    });
  }
}

import 'dart:developer';

import 'package:core/common/constants/app_locale.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/message/bloc/message_bloc.dart';
import 'package:teacher/screens/message/message_screen.dart';
import 'package:teacher/screens/message/screens/conversation_detail.dart';
import 'package:teacher/screens/notifications/detail/notification_detail_screen.dart';
import 'package:teacher/screens/splash/loading_screen.dart';

import 'package:intl/intl.dart' as intl;

final mainNavKey = GlobalKey<NavigatorState>();

class TeacherApp extends StatefulWidget {
  const TeacherApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.appFetchApiRepository,
  });

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final AppFetchApiRepository appFetchApiRepository;

  @override
  State<TeacherApp> createState() => _TeacherAppState();
}

class _TeacherAppState extends State<TeacherApp> {
  @override
  void initState() {
    super.initState();
    FirebaseNotificationService.shared.notiOpened = onNotificationOpened;
    FirebaseNotificationService.shared.notiReceived = onReceiveNotification;

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        FirebaseNotificationService.shared.handleNotification(message?.data);
        FirebaseNotificationService.shared.onReceiveNotification(message?.data);
      },
    );
  }

  void onNotificationOpened(Map<String, dynamic>? data) {
    log("TeacherApp - onNotificationOpened: $data");
    final notiType = data?['type'];
    switch (notiType) {
      case 'notification':
        final notiId = data?['id'] as String;

        mainNavKey.currentContext?.push(
          NotiDetailScreen(
            id: int.tryParse(notiId) ?? 0,
          ),
        );
        break;

      case 'message':
        final conversationId = data?['conversation_id'];
        final recipientId = data?['recipient_id'];

        mainNavKey.currentContext?.push(
          ConversationDetail(
            conversationId: conversationId,
            recipientId: recipientId,
          ),
        );

        final currentContext = mainNavKey.currentState!.context;
        currentContext
            .read<MessageBloc>()
            .add(GetConservationDetail(conversationId: conversationId));

      default:
    }
  }

  void onReceiveNotification(Map<String, dynamic>? data) async {
    log("TeacherApp - onReceiveNotification: $data");
    final notiType = data?['type'];

    switch (notiType) {
      case 'message':
        final conversationId = data?['conversation_id'];
        final currentContext = mainNavKey.currentState!.context;
        bool isMessageScreen = false;
        bool isMessageDetail = false;

        currentContext.popUntil(predicate: (Route route) {
          if (route.settings.name == MessageScreen.routeName) {
            isMessageScreen = true;
          }
          return true;
        });

        if (isMessageScreen) {
          currentContext.read<MessageBloc>().add(GetConversationList());
        }
        currentContext.popUntil(predicate: (Route route) {
          if (route.settings.name == ConversationDetail.routeName) {
            isMessageDetail = true;
          }
          return true;
        });
        if (isMessageDetail) {
          currentContext
              .read<MessageBloc>()
              .add(GetConservationDetail(conversationId: conversationId));
        }
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: widget.authRepository),
          RepositoryProvider.value(value: widget.userRepository),
          RepositoryProvider.value(value: widget.appFetchApiRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CurrentUserBloc(
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider(
                create: (context) => MessageBloc(
                      appApiRepository: context.read<AppFetchApiRepository>(),
                      currentUserBloc: context.read<CurrentUserBloc>(),
                    )),
          ],
          child: BlocListener<CurrentUserBloc, CurrentUserState>(
            listenWhen: (previous, current) => previous.user != current.user,
            listener: (context, state) {},
            child: MaterialApp(
              navigatorKey: mainNavKey,
              debugShowCheckedModeBanner: false,
              locale: AppLocale.vi,
              localizationsDelegates: const [
                CustomMaterialLocalizationsDelegate(),
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

class CustomMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      kMaterialSupportedLanguages.contains(locale.languageCode);

  static final Map<Locale, Future<MaterialLocalizations>> _loadedTranslations =
      <Locale, Future<MaterialLocalizations>>{};

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    assert(isSupported(locale));
    return _loadedTranslations.putIfAbsent(locale, () {
      final String localeName =
          intl.Intl.canonicalizedLocale(locale.toString());
      assert(
        locale.toString() == localeName,
        'Flutter does not support the non-standard locale form $locale (which '
        'might be $localeName',
      );

      intl.DateFormat fullYearFormat;
      intl.DateFormat compactDateFormat;
      intl.DateFormat shortDateFormat;
      intl.DateFormat mediumDateFormat;
      intl.DateFormat longDateFormat;
      intl.DateFormat yearMonthFormat;
      intl.DateFormat shortMonthDayFormat;
      if (intl.DateFormat.localeExists(localeName)) {
        fullYearFormat = intl.DateFormat.y(localeName);
        compactDateFormat = intl.DateFormat.yMd(localeName);
        shortDateFormat = intl.DateFormat.yMMMd(localeName);
        // mediumDateFormat = intl.DateFormat.MMMEd(localeName);
        longDateFormat = intl.DateFormat.yMMMMEEEEd(localeName);
        // yearMonthFormat = intl.DateFormat.yMMMM(localeName);
        shortMonthDayFormat = intl.DateFormat.MMMd(localeName);
      } else if (intl.DateFormat.localeExists(locale.languageCode)) {
        fullYearFormat = intl.DateFormat.y(locale.languageCode);
        compactDateFormat = intl.DateFormat.yMd(locale.languageCode);
        shortDateFormat = intl.DateFormat.yMMMd(locale.languageCode);
        // mediumDateFormat = intl.DateFormat.MMMEd(locale.languageCode);
        longDateFormat = intl.DateFormat.yMMMMEEEEd(locale.languageCode);
        // yearMonthFormat = intl.DateFormat.yMMMM(locale.languageCode);
        shortMonthDayFormat = intl.DateFormat.MMMd(locale.languageCode);
      } else {
        fullYearFormat = intl.DateFormat.y();
        compactDateFormat = intl.DateFormat.yMd();
        shortDateFormat = intl.DateFormat.yMMMd();
        // mediumDateFormat = intl.DateFormat.MMMEd();
        longDateFormat = intl.DateFormat.yMMMMEEEEd();
        // yearMonthFormat = intl.DateFormat.yMMMM();
        shortMonthDayFormat = intl.DateFormat.MMMd();
      }

      // READ ONLY HERE
      mediumDateFormat = intl.DateFormat("dd LLLL, y", 'vi_VN'); //
      yearMonthFormat = intl.DateFormat("LLLL, y", 'vi_VN'); //

      intl.NumberFormat decimalFormat;
      intl.NumberFormat twoDigitZeroPaddedFormat;
      if (intl.NumberFormat.localeExists(localeName)) {
        decimalFormat = intl.NumberFormat.decimalPattern(localeName);
        twoDigitZeroPaddedFormat = intl.NumberFormat('00', localeName);
      } else if (intl.NumberFormat.localeExists(locale.languageCode)) {
        decimalFormat = intl.NumberFormat.decimalPattern(locale.languageCode);
        twoDigitZeroPaddedFormat = intl.NumberFormat('00', locale.languageCode);
      } else {
        decimalFormat = intl.NumberFormat.decimalPattern();
        twoDigitZeroPaddedFormat = intl.NumberFormat('00');
      }

      return SynchronousFuture<MaterialLocalizations>(getMaterialTranslation(
        locale,
        fullYearFormat,
        compactDateFormat,
        shortDateFormat,
        mediumDateFormat,
        longDateFormat,
        yearMonthFormat,
        shortMonthDayFormat,
        decimalFormat,
        twoDigitZeroPaddedFormat,
      ) as MaterialLocalizations);
    });
  }

  @override
  bool shouldReload(CustomMaterialLocalizationsDelegate old) => false;

  @override
  String toString() =>
      'GlobalMaterialLocalizations.delegate(${kMaterialSupportedLanguages.length} locales)';
}

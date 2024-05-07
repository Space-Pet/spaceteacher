import 'package:core/presentation/modules/webview/webview_screen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/notifications/detail/bloc/noti_detail_bloc.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:repository/repository.dart';

class NotiDetailScreen extends StatelessWidget {
  const NotiDetailScreen({super.key, required this.id});

  static const String routeName = '/noti-detail';
  final int id;

  @override
  Widget build(BuildContext context) {
    final notiDetailBloc = NotiDetailBloc(
      context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );

    return BlocProvider.value(
      value: notiDetailBloc..add(NotificationFetchDetail(id: id)),
      child: const NotiDetailView(),
    );
  }
}

class NotiDetailView extends StatelessWidget {
  const NotiDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotiDetailBloc, NotiDetailState>(
      builder: (context, state) {
        final notiDetail = state.notiDetail;

        final htmlContent = '''
            <html>
              <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
              </head>
              <body>
                <pre style="word-wrap: break-word; white-space: pre-wrap;">
                  ${notiDetail.content}
              </pre>
            </body>
          </html>
        ''';

        return Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: notiDetail.title,
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: WebViewScreen(
                      params: WebViewArgs(
                        html: htmlContent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

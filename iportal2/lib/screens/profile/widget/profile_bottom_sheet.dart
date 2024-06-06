import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/app_main_layout.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/utils/utils_export.dart';

class SelectChildrenBottomSheet extends StatelessWidget {
  const SelectChildrenBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final listChildren = state.user.children;

        final listChilderW = List.generate(listChildren.length, (index) {
          final child = listChildren[index];
          return InkWell(
            onTap: () {
              context
                  .read<CurrentUserBloc>()
                  .add(CurrentUserChangeActiveChild(child));

              Navigator.popUntil(mainNavKey.currentContext!, (route) => false);
              mainNavKey.currentContext?.push(const AppMainLayout());
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: index == listChildren.length - 1
                        ? Colors.transparent
                        : AppColors.gray100,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'assets/images/default-user.png',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            child.full_name,
                            style: AppTextStyles.semiBold12(
                              height: 18 / 12,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icons.academic,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  child.school_name,
                                  style: AppTextStyles.normal12(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.gray400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  child.class_name,
                                  style: AppTextStyles.normal12(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  if (child.isActive)
                    const Icon(
                      Icons.check_circle_sharp,
                      color: AppColors.brand600,
                    ),
                ],
              ),
            ),
          );
        });

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: listChilderW,
            ),
          ),
        );
      },
    );
  }
}

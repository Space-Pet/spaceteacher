import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/conversation/conversation_screen.dart';
import 'package:teacher/src/screens/profile/view/profile_screen.dart';
import 'package:teacher/src/utils/extension_context.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
    required this.user,
  });

  final UserInfo user;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 36, 8, 28),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              final res = await context.push(
                ProfileScreen.routeName,
                arguments: {
                  'userInfo': widget.user,
                },
              );

              if (res == true) {
                setState(() {});
              }
            },
            child: CircleAvatar(
              backgroundColor: AppColors.blackTransparent,
              radius: 21,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.user.children?.urlImageModel?.mobile ??
                    widget.user.schoolLogo ??
                    '',
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.user.name}",
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.user.className ?? widget.user.typeText ?? '',
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              context.push(ConversationScreen.routeName);
            },
            child: CircleAvatar(
              backgroundColor: AppColors.whiteOpacity.withOpacity(0.3),
              radius: 20,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.transparent,
                child: Assets.images.noti.image(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

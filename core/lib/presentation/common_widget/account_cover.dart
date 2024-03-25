import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants.dart';
import '../theme/theme_color.dart';
import 'export.dart';

class AccountCover extends StatelessWidget {
  final File? newAvatar;
  final String? avatarUrl;
  final Function()? onTap;
  final bool canEdit;

  AccountCover({
    Key? key,
    this.newAvatar,
    this.avatarUrl,
    this.onTap,
    this.canEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: themeColor.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: _avatarImage(),
          ),
        ],
      ),
    );
  }

  Widget _avatarImage() {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: themeColor.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: themeColor.color8D8D94,
              offset: const Offset(0, 2),
              spreadRadius: -1,
              blurRadius: 2,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              bottom: 8,
              right: 8,
              child: CircleImage(
                child: _circleImage(),
              ),
            ),
            if (canEdit)
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(coreImageConstant.icCamera),
              )
          ],
        ),
      ),
    );
  }

  Widget _circleImage() {
    if (newAvatar != null) {
      return Image.file(
        newAvatar!,
        fit: BoxFit.cover,
      );
    }
    if (avatarUrl != null && avatarUrl?.isNotEmpty == true) {
      return CachedNetworkImageWrapper.avatar(
        url: avatarUrl ?? '',
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }
    return SvgPicture.asset(
      coreImageConstant.icUserAvatar,
      fit: BoxFit.cover,
    );
  }
}

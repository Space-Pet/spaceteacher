part of '../constants.dart';

CoreImageConstant get coreImageConstant => injector.get<CoreImageConstant>();

abstract class CoreImageConstant {
  String get icArrowLeft => 'assets/images/svg/ic_arrow_left.svg';
  String get iconWarning => 'assets/images/svg/icon_warning.svg';

  String get icUserAvatar => 'assets/images/svg/ic_user_avatar.svg';
  String get icTime => 'assets/images/svg/ic_time.svg';
  String get icPlay => 'assets/images/svg/ic_play.svg';
  String get icCamera => 'assets/images/svg/ic_camera.svg';

  String get imgScreenFormHeader =>
      'assets/images/png/teacher_banner_login.png';
  String get imgMainFormHeader => 'assets/images/png/teacher_header.png';
  String get imgLongHeader => 'assets/images/png/img_teacher_long_header.png';
  String get icChevronRight => 'assets/images/svg/ic_chevron_right.svg';
  String get icRemind => 'assets/images/svg/ic_remind.svg';
}

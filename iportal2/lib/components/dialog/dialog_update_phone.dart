import 'package:core/common/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';

class PhoneUpdate extends StatelessWidget {
  const PhoneUpdate({
    super.key,
    required this.bloc,
    this.isParent = false,
    this.isFather = true,
  });

  final ProfileBloc bloc;
  final bool isParent;
  final bool isFather;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.successUpdate) {
            Navigator.pop(context);
            SnackBarUtils.showFloatingSnackBar(
                context, 'Cập nhật số điện thoại thành công');
          }
        },
        builder: (context, state) {
          final phone = state.phoneUpdate;
          final errMsg = state.errMessage;

          return Container(
            width: 300.h,
            decoration: ShapeDecoration(
              color: AppColors.blueGray25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Cập nhật số điện thoại',
                  style: AppTextStyles.semiBold18(color: AppColors.gray900),
                ),
                const SizedBox(height: 16),
                TitleAndInputText(
                  textInputType: false,
                  isValid: !errMsg.isNotEmpty,
                  title: '',
                  hintText: 'Nhập số điện thoại mới',
                  onChanged: (value) {
                    bloc.add(UpdatePhone(newPhoneNum: value));
                  },
                  prefixIcon: Assets.icons.phone.image(),
                ),
                if (errMsg.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errMsg,
                      style: AppTextStyles.normal14(color: AppColors.redMenu),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      if (phone.length != 10) {
                        return;
                      }
                      if (isParent) {
                        bloc.add(UpdateParentPhone(
                          phone: phone,
                          isFather: isFather,
                        ));
                      } else {
                        bloc.add(UpdateStudentPhone(
                          phone: phone,
                          motherName: state.studentData.parent.motherName,
                          fatherPhone: state.studentData.parent.fatherPhone,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: phone.length != 10
                          ? AppColors.gray100
                          : AppColors.redMenu,
                    ),
                    child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Lưu lại',
                          style:
                              AppTextStyles.semiBold16(color: AppColors.white),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(AppColors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: AppColors.gray300),
                    ),
                  ),
                  onPressed: () {
                    bloc.add(const CancelUpdatePhone());
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        style:
                            AppTextStyles.semiBold16(color: AppColors.gray900),
                        'Hủy',
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

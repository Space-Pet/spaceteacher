import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/authentication/login/view/login_screen.dart';
import 'package:iportal2/screens/splash/bloc/splash_cubit.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:repository/repository.dart';
import '../../resources/app_strings.dart';

class CurvedSplashScreen extends StatelessWidget {
  const CurvedSplashScreen({
    Key? key, // Đảm bảo key là kiểu Key, không phải super.key
    required this.screensLength,
    required this.screenBuilder,
    this.nextText = AppStrings.nextText,
    this.skipText = AppStrings.skipText,
    this.textColor = const Color(0xFF181818),
    this.backgroundColor = Colors.white,
  }) : super(key: key); // Thêm super(key: key) vào đây để tránh lỗi

  /// Number of screens you want to add
  final int screensLength;

  /// Widget that appears on each screen according to index
  final Widget Function(int index) screenBuilder;

  /// Text label to the back button.
  final String nextText;

  /// Text label to the skip button.
  final String skipText;

  /// Color given to the forward back and skip text the, default is White.
  final Color textColor;

  /// Color given to the backgroud of the screen, default is White.
  final Color backgroundColor;

  static const routeName = 'splashScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          final splashCubit = BlocProvider.of<SplashCubit>(context);
          // Thực hiện các thao tác với splashCubit ở đây nếu cần
          splashCubit.splashCleanToken();
          return CurvedSplashView(
            screensLength: screensLength,
            screenBuilder: screenBuilder,
            nextText: nextText,
            skipText: skipText,
            textColor: textColor,
            backgroundColor: backgroundColor,
          );
        },
      ),
    );
  }
}

// Phần code còn lại không thay đổi

class CurvedSplashView extends StatefulWidget {
  /// Number of screens you want to add
  final int screensLength;

  /// Widget that appears on each screen according to index
  final Widget Function(int index) screenBuilder;

  /// Text label to the back button.
  final String nextText;

  /// Text label to the skip button.
  final String skipText;

  /// Color given to the forward back and skip text the, default is White.
  final Color textColor;

  /// Color given to the backgroud of the screen, default is White.
  final Color backgroundColor;
  const CurvedSplashView({
    super.key,
    required this.screensLength,
    required this.screenBuilder,
    this.nextText = AppStrings.nextText,
    this.skipText = AppStrings.skipText,
    this.textColor = const Color(0xFF181818),
    this.backgroundColor = Colors.white,
  });

  @override
  State<CurvedSplashView> createState() => _CurvedSplashViewState();
}

class _CurvedSplashViewState extends State<CurvedSplashView> {
  int currentPageIndex = 0;
  late PageController _pageController;
  void saveData() async {
    await Hive.openBox('boxFistTime');
    final box = Hive.box('boxFistTime');
    await box.put('boxFistTime', false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    _pageController = PageController(initialPage: 0);
    saveData();
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: PageView.builder(
                itemCount: widget.screensLength,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) =>
                    Center(child: widget.screenBuilder(index)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedSheet(
                totalPages: widget.screensLength,
                currentPage: currentPageIndex,
                nextText: widget.nextText,
                skipText: widget.skipText,
                textColor: widget.textColor,
                backgroundColor: widget.backgroundColor,
                onPressedChange: () async {
                  context.pushReplacement(LoginScreen());
                },
                skip: () {
                  context.pushReplacement(LoginScreen());
                },
                next: () {
                  if (_pageController.page! < 2) {
                    _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}

class CurvedSheet extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function next;
  final Function skip;
  final String nextText;
  final String skipText;
  final Color textColor;
  final Color backgroundColor;
  final Function() onPressedChange;
  const CurvedSheet({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.next,
    required this.skip,
    required this.nextText,
    required this.skipText,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressedChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: currentPage != 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            skip();
                          },
                          child: Text(
                            skipText,
                            style: const TextStyle(color: AppColors.gray400),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getSplashDots(totalPages, currentPage)),
                        TextButton(
                            onPressed: () {
                              next();
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$nextText  ',
                                    // style: AppTextStyles.textSmallRedNormal
                                  ),
                                ],
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.gray500,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onPressedChange,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              backgroundColor: const Color(0xFF9C292E),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 17, bottom: 17),
                              child: Text(
                                'Bắt đầu ngay',
                                style: TextStyle(
                                    height: 0.09,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}

List<Widget> getSplashDots(int maxLength, int selectedDot) {
  List<Widget> dots = [];
  for (int i = 0; i < maxLength; i++) {
    dots.add(
      Row(
        children: [
          Container(
            height: getRelativeHeight(0.01),
            decoration: BoxDecoration(
                color:
                    selectedDot == i ? AppColors.brand600 : AppColors.gray400,
                borderRadius: BorderRadius.circular(15)),
            width: selectedDot == i
                ? getRelativeWidth(0.022)
                : getRelativeWidth(0.022),
          ),
          if (i < maxLength - 1) ...[
            SizedBox(width: getRelativeWidth(0.015)),
          ]
        ],
      ),
    );
  }
  return dots;
}

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}

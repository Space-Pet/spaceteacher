import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:core/resources/app_colors.dart';
import 'package:teacher/resources/assets.gen.dart';

class CustomRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  _CustomRefreshState createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh>
    with SingleTickerProviderStateMixin {
  static const _indicatorSize = 80.0;

  bool _renderCompleteState = false;
  bool _isShowLoading = false;
  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: widget.onRefresh,
      child: widget.child,
      onStateChanged: (change) {
        if (change.currentState.isDragging) {
          setState(() {
            _isShowLoading = true;
          });
        }

        if (change.currentState.isFinalizing) {
          setState(() {
            _isShowLoading = false;
          });
        }

        if (change.currentState.isCanceling) {
          setState(() {
            _isShowLoading = false;
          });
        }

        if (change.didChange(to: IndicatorState.complete)) {
          setState(() {
            _renderCompleteState = true;
          });
        } else if (change.didChange(to: IndicatorState.idle)) {
          setState(() {
            _renderCompleteState = false;
          });
        }
      },
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? _) {
                prevScrollDirection = controller.scrollingDirection;
                final containerHeight = controller.value * _indicatorSize;

                return !_isShowLoading
                    ? const SizedBox()
                    : Container(
                        alignment: Alignment.center,
                        height: containerHeight,
                        child: OverflowBox(
                          maxHeight: 50,
                          minHeight: 50,
                          maxWidth: 50,
                          minWidth: 50,
                          child: AnimatedContainer(
                            width: 50,
                            height: 50,
                            duration: const Duration(milliseconds: 150),
                            alignment: Alignment.center,
                            child: _renderCompleteState
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40.0)),
                                      image: DecorationImage(
                                        image: Assets.images.logoApp.circleLogo
                                            .provider(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 40,
                                    width: 40,
                                  )
                                : Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(40.0)),
                                            image: DecorationImage(
                                              image: Assets
                                                  .images.logoApp.circleLogo
                                                  .provider(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                      const Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                AppColors.brand600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _indicatorSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }
}

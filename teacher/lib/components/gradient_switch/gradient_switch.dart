import 'package:flutter/material.dart';

class GradientSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final LinearGradient gradient;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.gradient,
  });

  @override
  _GradientSwitchState createState() => _GradientSwitchState();
}

class _GradientSwitchState extends State<GradientSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: widget.gradient,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment:
                  widget.value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 150),
              // curve: Curves.decelerate,
              child: Container(
                padding: const EdgeInsets.all(4),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomSwitch(
      {super.key,
      required this.value,
      this.onChanged,
      this.activeColor,
      this.inactiveColor = Colors.grey,
      this.activeText = '',
      this.inactiveText = '',
      this.activeTextColor = Colors.white70,
      this.inactiveTextColor = Colors.white70});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged?.call(true)
                : widget.onChanged?.call(false);
          },
          child: Container(
            width: 44.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // I commented here.
              color: (widget.value) ? widget.inactiveColor : widget.activeColor,

              gradient: widget.value
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF037236), // #037236
                        Color(0xFF52BB58), // #52BB58
                      ],
                    )
                  : const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 124, 124, 124), // #037236
                        Color.fromARGB(255, 94, 94, 94), // #52BB58
                      ],
                    ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 2),
                          child: Text(
                            widget.activeText,
                            style: TextStyle(
                                color: widget.activeTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: const EdgeInsets.only(left: 2, right: 16.0),
                          child: Text(
                            widget.inactiveText,
                            style: TextStyle(
                                color: widget.inactiveTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

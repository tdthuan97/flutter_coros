import 'package:coros/color_config.dart';
import 'package:flutter/material.dart';

import 'watch_border_painter.dart';

class WatchWidget extends StatefulWidget {
  const WatchWidget(
      {Key? key,
      required this.apiFinished,
      required this.valueNotifier,
      required this.startApi})
      : super(key: key);
  final bool apiFinished;
  final bool startApi;
  final ValueNotifier<double> valueNotifier;

  @override
  State<WatchWidget> createState() => _WatchWidgetState();
}

class _WatchWidgetState extends State<WatchWidget>
    with TickerProviderStateMixin {
  late AnimationController animationControllerCheck;
  late Animation<double> animationCheck;

  late ValueNotifier<double> valueNotifier;

  late AnimationController animationControllerBorder;
  late Animation<double> animationBorder;

  late AnimationController animationControllerGreen;
  late Animation<double> animationGreen;

  @override
  void initState() {
    super.initState();
    animationControllerCheck = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animationCheck =
        Tween(begin: 0.0, end: 1.0).animate(animationControllerCheck);

    animationControllerBorder = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animationBorder =
        Tween(begin: 0.0, end: 1.0).animate(animationControllerBorder);

    animationControllerGreen = AnimationController(
      vsync: this,
      value: 1.0,
      duration: const Duration(milliseconds: 100),
    );
    animationGreen =
        Tween(begin: 0.0, end: 1.0).animate(animationControllerGreen);

    // animationControllerBorder.addStatusListener((status) {
    //   if (status == AnimationStatus.completed && animationBorder.value == 1) {
    //     animationController.animateTo(1.0,
    //         duration: const Duration(milliseconds: 1000),
    //         curve: Curves.easeInCirc);
    //   }
    // });

    valueNotifier = widget.valueNotifier;
  }

  onProcessGreenCircle() {
    animationControllerGreen
        .animateTo(0.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInCirc)
        .then((value) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          animationControllerGreen.animateTo(1.0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInCirc);
        },
      );
    });
  }

  @override
  void didUpdateWidget(covariant WatchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apiFinished) {
      animationControllerCheck.animateTo(1.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInCirc);
    } else {
      // animationController.animateBack(0.0, duration: const Duration(milliseconds: 5000),);
      animationControllerCheck
          .animateTo(0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInCirc)
          .then((value) {
        onProcessGreenCircle();
      });
    }

    if (widget.startApi) {
      onProcessGreenCircle();
      animationControllerBorder.value = 1.0;
    } else {
      // animationController.animateBack(0.0, duration: const Duration(milliseconds: 5000),);
      animationControllerBorder.animateTo(0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInCirc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
              animation: animationCheck,
              builder: (context, child) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Stack(
                    fit: StackFit.expand,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: valueNotifier,
                        builder: (context, value, child) {
                          return AnimatedBuilder(
                              animation: animationBorder,
                              builder: (context, child) {
                                return Visibility(
                                  visible: widget.startApi ||
                                      animationBorder.value != 0,
                                  child: Center(
                                    child: Opacity(
                                      opacity: animationBorder.value,
                                      child: SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: CustomPaint(
                                          painter: WatchBorderPainter(value),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      const Icon(
                        Icons.watch_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      Center(
                        child: animationCheck.value == 0.0
                            ? Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0.2,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Opacity(
                                opacity: animationCheck.value,
                                child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 0.2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: const Icon(Icons.check,
                                        color: ColorConfig.primaryColor,
                                        size: 8.0)),
                              ),
                      )
                    ],
                  ),
                );
              }),
        ),
        Positioned(
          top: 15,
          right: 10.0,
          child: AnimatedBuilder(
            animation: animationGreen,
            builder: (context, child) {
              return Opacity(
                opacity: animationGreen.value,
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: const BoxDecoration(
                      color: Color(0xff28D362), shape: BoxShape.circle),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

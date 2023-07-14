import 'package:flutter/material.dart';

import 'level_control_painter.dart';

class LevelControlPercentWidget extends StatefulWidget {
  const LevelControlPercentWidget({Key? key}) : super(key: key);

  @override
  State<LevelControlPercentWidget> createState() =>
      _LevelControlPercentWidgetState();
}

class _LevelControlPercentWidgetState extends State<LevelControlPercentWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<LevelControlPercentWidget> {
  late AnimationController animationController;

  late Animation<double> animation;

  Offset offset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.animateTo(0.0,
          duration: const Duration(milliseconds: 800), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  @override
  void didUpdateWidget(covariant LevelControlPercentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.value != oldWidget.value) {
    //   animationController.animateTo(widget.value,
    //       duration: const Duration(milliseconds: 500), curve: Curves.linear);
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                // color: Colors.red,
                height: 145,
                width: 210,
                child: Center(
                  child: Container(
                    // color: Colors.grey.withOpacity(0.5),
                    height: 90,
                    width: 190,
                    child: GestureDetector(
                      onTapDown: (details) {
                        Offset offsetLocal = details.localPosition;

                        double percent = (offsetLocal.dx / 190);
                        animationController.animateTo(percent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);

                      },
                      // onLongPressMoveUpdate: (details){
                      //   Offset offsetLocal = details.localPosition;
                      //
                      //   double percent = (offsetLocal.dx / 190);
                      //   animationController.animateTo(percent,
                      //       duration: const Duration(milliseconds: 500),
                      //       curve: Curves.linear);
                      // },
                      child: CustomPaint(
                        painter: LevelControlPainter(animation.value * 100),
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                  bottom: 0,
                  left: 6,
                  child: Text(
                    "0",
                    style: TextStyle(color: Colors.grey),
                  )),
              const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    "100",
                    style: TextStyle(color: Colors.grey),
                  )),
              Positioned(
                bottom: 10,
                child: Text(
                  (animation.value * 100).toDouble().toStringAsFixed(1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Text(
              //     (animation.value * 100).toDouble().toStringAsFixed(1),
              //     style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 36,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

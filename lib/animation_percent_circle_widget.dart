import 'package:flutter/material.dart';

import 'circle_painter.dart';

class AnimationPercentCircleWidget extends StatefulWidget {
  const AnimationPercentCircleWidget({Key? key, this.value = 0.0})
      : super(key: key);
  final double value;

  @override
  State<AnimationPercentCircleWidget> createState() =>
      _AnimationPercentCircleWidgetState();
}

class _AnimationPercentCircleWidgetState
    extends State<AnimationPercentCircleWidget>
    with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin<AnimationPercentCircleWidget> {
  late AnimationController animationController;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.animateTo(widget.value,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInCirc);
    });
  }
  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }
  @override
  void didUpdateWidget(covariant AnimationPercentCircleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      animationController.animateTo(widget.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInCirc);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            width: 125,
            height: 125,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: CirclePainter(animation.value),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        (animation.value * 100).toInt().toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Text(
                        "kcal",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

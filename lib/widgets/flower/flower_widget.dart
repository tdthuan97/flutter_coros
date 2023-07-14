import 'dart:math';

import 'package:flutter/material.dart';

import 'flower_painter.dart';

class LineModel {
  final int value;
  final int addValue;

  LineModel({required this.value, required this.addValue});
}

class FlowerWidget extends StatefulWidget {
  const FlowerWidget({Key? key}) : super(key: key);

  @override
  State<FlowerWidget> createState() => _FlowerWidgetState();
}

class _FlowerWidgetState extends State<FlowerWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<FlowerWidget> {
  late Animation<int> animation;
  late AnimationController controller;

  List<LineModel> listLines = [];

  int? temptAnimation;

  // late Timer _timer;
  var rng = Random();

  // double _value = -180;
  //
  // void startTimer() {
  //   const oneSec = Duration(milliseconds: 30);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       listLines.add(LineModel(value:_value, addValue:  rng.nextInt(8) ));
  //       setState(() {});
  //       _value = _value + 10;
  //       if (_value > 180) {
  //         _timer.cancel();
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // startTimer();

    // Tween<int> _rotationTween = Tween(begin: -180, end: 180);
    // Tween<int> _rotationTween = IntTween(begin: -180, end: 180);
    //
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 3),
    // );
    //
    // animation = _rotationTween.animate(CurvedAnimation(
    //     parent: controller, curve: Curves.linear))
    //   ..addListener(() {
    //     final _value = animation.value;
    //     print("_value $_value");
    //     print("temptAnimation ${temptAnimation.toString()}");
    //     if (temptAnimation == null) {
    //       listLines.add(LineModel(value: _value, addValue: rng.nextInt(8)));
    //       temptAnimation = _value;
    //     } else if (_value % 10 == 0) {
    //       listLines.add(LineModel(value: _value, addValue: rng.nextInt(8)));
    //       temptAnimation = _value;
    //     }
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       // controller.repeat();
    //       print(listLines);
    //     } else if (status == AnimationStatus.dismissed) {
    //       // controller.forward();
    //     }
    //   });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.forward();
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // color: Colors.teal,
      height: 250,
      width: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: CustomPaint(
              // size: const Size.fromRadius(80),
              painter: FlowerPainter(0, listLines),
            ),
          ),
          // AnimatedBuilder(
          //     animation: animation,
          //     builder: (context, child) {
          //       return SizedBox(
          //         height: 120,
          //         width: 120,
          //         child: CustomPaint(
          //           // size: const Size.fromRadius(80),
          //           painter: FlowerPainter(animation.value, listLines),
          //         ),
          //       );
          //     }),
          const Center(
            child: Icon(
              Icons.surfing_outlined,
              color: Colors.white,
              size: 45,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

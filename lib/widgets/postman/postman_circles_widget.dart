import 'package:coros/widgets/postman/postman_painter.dart';
import 'package:flutter/material.dart';

class PostmanCirclesWidget extends StatefulWidget {
  const PostmanCirclesWidget({Key? key}) : super(key: key);

  @override
  State<PostmanCirclesWidget> createState() => _PostmanCirclesWidgetState();
}

class _PostmanCirclesWidgetState extends State<PostmanCirclesWidget>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<PostmanCirclesWidget> {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    animation = Tween(begin: -180.0, end: 180.0).animate(animationController);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   animationController.forward();
    // });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 160,
      width: 160,
      child: Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size.fromRadius(80),
                painter: PostmanPainter(value: animation.value),
              );
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

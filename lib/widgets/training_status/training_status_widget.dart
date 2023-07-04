import 'package:flutter/material.dart';

import 'triangle_painter.dart';

class TrainingStatusWidget extends StatefulWidget {
  const TrainingStatusWidget({Key? key}) : super(key: key);

  @override
  State<TrainingStatusWidget> createState() => _TrainingStatusWidgetState();
}

class _TrainingStatusWidgetState extends State<TrainingStatusWidget> {
  List<Color> listColors = const [
    Color(0xff429AFC),
    Color(0xff2FC9CA),
    Color(0xffABDC36),
    Color(0xffFABE35),
    Color(0xffF1504D),
  ];

  @override
  Widget build(BuildContext context) {
    _itemStatus(int index, Color color) {
      return Container(
        height: 5.0,
        width: 22,
        margin: const EdgeInsets.only(right: 1.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(index == 0 ? 10 : 0),
                right:
                    Radius.circular(index == listColors.length - 1 ? 10 : 0))),
      );
    }

    return SizedBox(
      height: 30,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              ...listColors
                  .asMap()
                  .map((i, element) => MapEntry(i, _itemStatus(i, element)))
                  .values
                  .toList()
            ],
          ),
          Positioned(
            left: 55.0,
            child: SizedBox(
              height: 11,
              width: 11,
              child: CustomPaint(
                painter: TrianglePainter(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'cupertino_picker_widget.dart';

class WeightCupertinoPickerWidget extends StatefulWidget {
  const WeightCupertinoPickerWidget({
    Key? key,
    required this.callBackWeight,
    required this.weightHeight,
    this.indexKgCurrent = 0,
    this.indexGramCurrent = 0,
    this.heightWidget = 200,
  }) : super(key: key);
  final double weightHeight;
  final int indexKgCurrent;
  final int indexGramCurrent;
  final Function(double weight, int indexKg, int intGram) callBackWeight;

  final double heightWidget;

  @override
  State<WeightCupertinoPickerWidget> createState() =>
      _WeightCupertinoPickerWidgetState();
}

class _WeightCupertinoPickerWidgetState
    extends State<WeightCupertinoPickerWidget> {
  double _weightCurrent = 62.0;

  List<String> listKg = <String>[];
  List<String> listGram = <String>[];

  int _indexKgCurrent = 0;
  int _indexGramCurrent = 0;

  @override
  void initState() {
    super.initState();
    _weightCurrent = widget.weightHeight;
    _indexKgCurrent = widget.indexKgCurrent;
    _indexGramCurrent = widget.indexGramCurrent;

    for (int i = 0; i <= 9; i++) {
      listGram.add(i.toString());
    }

    for (int i = 1; i <= 500; i++) {
      listKg.add(i.toString());
    }

    List<String> listDataWeight = _weightCurrent.toString().split(".");
    _indexKgCurrent = listKg.indexOf(listDataWeight[0]);
    _indexGramCurrent = listGram.indexOf(listDataWeight[1]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightWidget,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CupertinoPickerWidget(
              capEndEdge: false,
              initialItem: _indexKgCurrent,
              mainAxisAlignment: MainAxisAlignment.end,
              offAxisFraction: -0.5,
              list: listKg,
              onSelectedItemChanged: (index) {
                _indexKgCurrent = index;
                // setState(() {
                _weightCurrent = double.parse(listKg[_indexKgCurrent]) +
                    double.parse("0.${listGram[_indexGramCurrent]}");
                // });
                widget.callBackWeight(
                    _weightCurrent, _indexKgCurrent, _indexGramCurrent);
              },
            ),
          ),
          // Expanded(child: const Text("cm"))
          Expanded(
            child: CupertinoPickerWidget(
              capStartEdge: false,
              capEndEdge: false,
              initialItem: _indexGramCurrent,
              list: listGram,
              prefixText: ".",
              mainAxisAlignment: MainAxisAlignment.end,
              padding: const EdgeInsets.only(right: 20),
              onSelectedItemChanged: (index) {
                _indexGramCurrent = index;
                // setState(() {
                _weightCurrent = double.parse(listKg[_indexKgCurrent]) +
                    double.parse("0.${listGram[_indexGramCurrent]}");
                // });
                widget.callBackWeight(
                    _weightCurrent, _indexKgCurrent, _indexGramCurrent);
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: CupertinoPickerWidget(
              capStartEdge: false,
              initialItem: 0,
              list: ["kg"],
              padding: const EdgeInsets.only(left: 20),
              mainAxisAlignment: MainAxisAlignment.start,
              onSelectedItemChanged: (index) {},
            ),
          )
        ],
      ),
    );
  }
}

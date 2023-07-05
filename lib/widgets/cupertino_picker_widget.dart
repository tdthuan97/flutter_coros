import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerWidget extends StatelessWidget {
  const CupertinoPickerWidget(
      {Key? key,
      required this.list,
      this.capEndEdge = true,
      this.capStartEdge = true,
      required this.initialItem,
      required this.onSelectedItemChanged,
      this.magnification = 1.22,
      this.useMagnifier = true,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.offAxisFraction = 0.0,
      this.prefixText = "",
      this.padding = EdgeInsets.zero})
      : super(key: key);
  final List<String> list;
  final bool capEndEdge;
  final bool capStartEdge;
  final int initialItem;
  final Function(int) onSelectedItemChanged;
  final MainAxisAlignment mainAxisAlignment;
  final double magnification;
  final bool useMagnifier;
  final double offAxisFraction;
  final String prefixText;
  final EdgeInsets padding;
  final double _kItemExtent = 32.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      magnification: magnification,
      squeeze: 1.2,
      useMagnifier: useMagnifier,
      itemExtent: _kItemExtent,
      offAxisFraction: offAxisFraction,
      diameterRatio: 1,
      // This sets the initial item.
      scrollController: FixedExtentScrollController(
        initialItem: initialItem,
      ),
      // This is called when selected item is changed.
      onSelectedItemChanged: onSelectedItemChanged,
      // (int selectedItem) {
      // setState(() {
      //   _selectedFruit = selectedItem;
      // });
      // },
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        capEndEdge: capEndEdge,
        capStartEdge: capStartEdge,
      ),
      children: List<Widget>.generate(list.length, (int index) {
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Padding(
              padding: padding,
              // EdgeInsets.only(
              //     left: mainAxisAlignment == MainAxisAlignment.start ? 50 : 0),
              child: Text(
                prefixText + list[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'dart:ui';

import 'package:coros/widgets/watch/watch_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'animation_percent_circle_widget.dart';
import 'color_config.dart';
import 'widgets/physical/physical_painter.dart';
import 'widgets/training_status/training_status_widget.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  ScrollController scrollController = ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool _blurAppbar = false;

  Offset dragGesturePosition = Offset.zero;
  bool showMagnifier = false;

  bool startApi = false;
  bool apiFinished = false;

  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);

  onGetApi() async {
    final dio = Dio();
    final response = await dio.get(
        'https://images.unsplash.com/photo-1687939307771-4440181ca6c2?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&dl=krisjanis-kazaks-gBBkQIgFkqo-unsplash.jpg',
        onReceiveProgress: (cur, total) {
      double percent = cur / total;
      valueNotifier.value = percent;
    });
  }

  /// refresh
  Future<void> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    setState(() {
      startApi = true;
    });
    await onGetApi();
    // await Future.delayed(const Duration(seconds: 2));
    setState(() {
      apiFinished = true;
      startApi = false;
      valueNotifier.value = 0.0;
    });
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          apiFinished = false;
        });
      },
    );
  }

  onShowMagnifier(dragUpdateDetailsValue) {
    setState(() {
      showMagnifier = true;
      dragGesturePosition = dragUpdateDetailsValue.localPosition;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (scrollController.offset > 10.0 && _blurAppbar == false) {
          setState(() {
            _blurAppbar = true;
          });
        }
        if (scrollController.offset <= 1.0 && _blurAppbar) {
          setState(() {
            _blurAppbar = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTop = const TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);

    _top() {
      return ClipRect(
        child: Container(
          color: _blurAppbar
              ? ColorConfig.primaryColor.withOpacity(0.5)
              : Colors.transparent,
          child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: _blurAppbar ? 10.0 : 0.0,
                  sigmaY: _blurAppbar ? 10.0 : 0.0),
              child: SafeArea(
                child: Container(
                  height: kToolbarHeight,
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: _blurAppbar
                        ? ColorConfig.primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WatchWidget(
                        apiFinished: apiFinished,
                        startApi: startApi,
                        valueNotifier: valueNotifier,
                      ),
                      if (_blurAppbar)
                        const Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      );
    }

    _middle() {
      __itemMiddleWidget(
          {IconData? iconData,
          required Color colorIconData,
          required String title,
          Widget? leftValueWidget,
          Widget? rightValueWidget,
          String? content,
          double paddingVertical = 20.0}) {
        return Container(
          // constraints: const BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff161B31),
          ),
          padding:
              EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    color: colorIconData,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (leftValueWidget != null) leftValueWidget,
                          if (content != null) ...[
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              content,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: leftValueWidget != null ? 12 : 14),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                  if (rightValueWidget != null) rightValueWidget
                ],
              ),
            ],
          ),
        );
      }

      return LayoutBuilder(
        builder: (context, constraint) {
          return CustomRefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              await refreshList();
            },
            builder: MaterialIndicatorDelegate(
              builder: (context, controller) {
                return const Icon(
                  Icons.ac_unit,
                  color: Colors.blue,
                  size: 30,
                );
              },
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics:
                  // NeverScrollableScrollPhysics(),
                  const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // width: MediaQuery.of(context).size.width,
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onPanUpdate: onShowMagnifier,
                          onPanEnd: (details) {
                            setState(() {
                              showMagnifier = false;
                            });
                          },
                          onLongPressEnd: (details) {
                            setState(() {
                              showMagnifier = false;
                            });
                          },
                          // onLongPressDown: onLongPressDownDetails,
                          onLongPressMoveUpdate: onShowMagnifier,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: kToolbarHeight,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.accessible_outlined,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          2064.toString(),
                                          style: textStyleTop,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        const Text(
                                          "bước",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: valueNotifier,
                                    builder: (context, value, child) {
                                      return const AnimationPercentCircleWidget(
                                        value: 0.5,
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.access_time_filled_outlined,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          3.toString(),
                                          style: textStyleTop,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        const Text(
                                          "phút",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              __itemMiddleWidget(
                                  iconData: Icons.calendar_today_outlined,
                                  colorIconData: Colors.blue,
                                  title: "Lịch tập",
                                  content: "Tuần này không có lịch tập"),
                              __itemMiddleWidget(
                                  iconData: Icons.stacked_bar_chart,
                                  colorIconData: const Color(0xff449BFA),
                                  title: "Tình trạng luyện tập",
                                  rightValueWidget:
                                      const TrainingStatusWidget(),
                                  leftValueWidget: const Text(
                                    "Đang giảm",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
                              __itemMiddleWidget(
                                iconData: Icons.bolt_outlined,
                                colorIconData: const Color(0xff31B8BD),
                                title: "Hồi phục",
                                content: "Hồi phục hoàn toàn",
                                paddingVertical: 10.0,
                                leftValueWidget: const Text(
                                  "100%",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                rightValueWidget: Container(
                                  height: 70,
                                  width: 120,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: CustomPaint(
                                          painter: PhysicalPainter(1.0),
                                        ),
                                      ),
                                      Column(
                                        children: const [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Icon(Icons.self_improvement_outlined,
                                              color: Colors.white, size: 40),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Sảng khoái",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              __itemMiddleWidget(
                                  iconData: Icons.directions_run_outlined,
                                  colorIconData: Colors.orange,
                                  title: "Năng lực chạy bộ",
                                  content:
                                      "Hoàn thành bài kiểm tra Năng lực chạy bộ với đồng hồ COROS"),
                              __itemMiddleWidget(
                                iconData: Icons.accessibility_new_outlined,
                                colorIconData: Colors.red,
                                title: "Trọng lượng cơ thể",
                                leftValueWidget: () {
                                  return Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      const Text(
                                        "62.0",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "kg",
                                        style:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: Colors.grey[500],
                                            size: 18,
                                          ))
                                    ],
                                  );
                                }(),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                            ],
                          ),
                        ),
                        if (showMagnifier)
                          Positioned(
                            left: dragGesturePosition.dx,
                            top: dragGesturePosition.dy,
                            child: const RawMagnifier(
                              size: Size(150, 150),
                              magnificationScale: 2,
                              focalPointOffset: Offset.zero,
                              decoration: MagnifierDecoration(
                                shape: CircleBorder(
                                  side:
                                      BorderSide(color: Colors.pink, width: 3),
                                ),
                              ),
                            ),
                          )
                      ],
                    )),
              ),
            ),
          );
        },
      );
      // return Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   // color: Colors.red,
      //   // margin: EdgeInsets.only(top: kToolbarHeight + 40),
      //   child:
      //       // LiquidPullToRefresh(
      //       //   springAnimationDurationInMilliseconds: 150,
      //       //   // key: _refreshIndicatorKey,	// key if you want to add
      //       //   onRefresh: () async {
      //       //     await Future.delayed(const Duration(milliseconds: 500));
      //       //   },
      //       // showChildOpacityTransition: false,
      //       // child:
      //
      //   // ),
      // );
    }

    return Stack(
      children: [
        Positioned.fill(child: _middle()),
        Align(
          alignment: Alignment.topCenter,
          child: _top(),
        )
      ],
    );
  }
}

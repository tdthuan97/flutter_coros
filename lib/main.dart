import 'dart:ui';

import 'package:coros/activity_page.dart';
import 'package:coros/process_page.dart';
import 'package:flutter/material.dart';

import 'color_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: ScrollBehavior().copyWith(overscroll: false),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  final List<Widget> _tabs = <Widget>[
    const ProcessPage(),
    const ActivityPage(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(_selectedIndex,
          duration: Duration(milliseconds: 50 * (_selectedIndex + 1)),
          curve: Curves.linear);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    _bottom() {
      __bottomNavigationBarItemWidget(IconData iconData, String label) {
        return BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Icon(iconData)),
          label: label,
        );
      }

      return Container(
        height: 70,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ColorConfig.primaryColor.withOpacity(0.5),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedLabelStyle: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
            unselectedItemColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              __bottomNavigationBarItemWidget(
                  Icons.energy_savings_leaf_outlined, "Tiến trình"),
              __bottomNavigationBarItemWidget(
                  Icons.format_list_bulleted_outlined, "Hoạt động"),
              __bottomNavigationBarItemWidget(Icons.map_outlined, "Khám phá"),
              __bottomNavigationBarItemWidget(
                  Icons.person_outline_outlined, "Hồ sơ"),
            ],
            currentIndex: _selectedIndex,
            //New
            onTap: _onItemTapped,
          ),
        ),
      );
    }

    _body() {
      return Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            children: _tabs,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottom(),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: _body(),
    );
  }
}

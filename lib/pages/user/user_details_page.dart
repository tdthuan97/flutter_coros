import 'package:coros/color_config.dart';
import 'package:coros/main.dart';
import 'package:coros/models/user.dart';
import 'package:coros/widgets/cupertino_picker_widget.dart';
import 'package:coros/widgets/weight_cupertino_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum EnumItemEdit { NONE, GENDER, HEIGHT, WEIGHT, BIRTHDAY }

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with AutomaticKeepAliveClientMixin<UserDetailsPage> {
  // User user = getIt<User>();

  double _kItemExtent = 32.0;

  DateTime dateTimeBirthday = DateTime(2000, 8, 10);

  EnumItemEdit enumItemEdit = EnumItemEdit.NONE;

  List<String> listGender = ["Nam", "Nữ", "Khác"];
  int indexGenderCurrent = 0;

  int heightCurrent = 169;
  int indexHeightCurrent = 0;

  List<String> listCm = <String>[];

  List<String> listKg = <String>[];
  List<String> listGram = <String>[];

  double weightCurrent = 62.0;

  int indexKgCurrent = 0;
  int indexGramCurrent = 0;

  initUser() {
    // user = User.fromMap({"name": "test"});
    // getIt<User>().update(name: test);
    // debugPrint(user.toString());
  }

  onSave() {
    User _user = getIt<User>();
    debugPrint(_user.toString());
  }

  @override
  void initState() {
    super.initState();
    initUser();
    for (int i = 30; i <= 280; i++) {
      listCm.add(i.toString());
    }
    indexHeightCurrent = listCm.indexOf(heightCurrent.toString());

    for (int i = 0; i <= 9; i++) {
      listGram.add(i.toString());
    }

    for (int i = 1; i <= 500; i++) {
      listKg.add(i.toString());
    }

    List<String> listDataWeight = weightCurrent.toString().split(".");
    indexKgCurrent = listKg.indexOf(listDataWeight[0]);
    indexGramCurrent = listGram.indexOf(listDataWeight[1]);
  }

  onTapItem(EnumItemEdit item) {
    if (item == enumItemEdit) {
      enumItemEdit = EnumItemEdit.NONE;
    } else {
      enumItemEdit = item;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    _appbar() {
      return AppBar(
        elevation: 0,
        backgroundColor: ColorConfig.backgroundColor,
        centerTitle: true,
        title: const Text("Thông tin cá nhân"),
        actions: [
          TextButton(
            onPressed: () {
              onSave();
            },
            child: const Text("Lưu"),
          ),
        ],
      );
    }

    _body() {
      __itemInfo(
          {required String title,
          required String value,
          bool checkSelection = true,
          bool borderBottom = true,
          required Function onTap,
          EnumItemEdit valueEnumItemEdit = EnumItemEdit.NONE}) {
        return InkWell(
          onTap: () {
            onTap();
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: checkSelection == false
                                  ? Colors.grey
                                  : valueEnumItemEdit == enumItemEdit
                                      ? Colors.blue
                                      : Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (borderBottom)
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: screenWidth,
                  height: 0.1,
                  color: Colors.grey,
                )
            ],
          ),
        );
      }

      __genderPickerWidget() {
        return SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPickerWidget(
                  initialItem: indexGenderCurrent,
                  list: listGender,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      indexGenderCurrent = index;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }

      __heightPickerWidget() {
        return SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPickerWidget(
                  capEndEdge: false,
                  initialItem: indexHeightCurrent,
                  mainAxisAlignment: MainAxisAlignment.end,
                  offAxisFraction: -0.5,
                  list: listCm,
                  onSelectedItemChanged: (index) {
                    indexHeightCurrent = index;
                    setState(() {
                      heightCurrent = int.parse(listCm[index]);
                    });
                  },
                ),
              ),
              // Expanded(child: const Text("cm"))
              Expanded(
                child: CupertinoPickerWidget(
                  capStartEdge: false,
                  initialItem: 0,
                  list: ["cm"],
                  mainAxisAlignment: MainAxisAlignment.start,
                  padding: const EdgeInsets.only(left: 50),
                  onSelectedItemChanged: (index) {},
                ),
              )
            ],
          ),
        );
      }

      __weightPickerWidget() {
        return WeightCupertinoPickerWidget(
          weightHeight: weightCurrent,
          indexKgCurrent: indexKgCurrent,
          indexGramCurrent: indexGramCurrent,
          callBackWeight: (weight, indexKg, indexGram){
            setState(() {
              weightCurrent = weight;
              indexKgCurrent = indexKg;
              indexGramCurrent = indexGram;
            });
          },
        );
        // return SizedBox(
        //   height: 200,
        //   child: Row(
        //     children: [
        //       Expanded(
        //         flex: 2,
        //         child: CupertinoPickerWidget(
        //           capEndEdge: false,
        //           initialItem: indexKgCurrent,
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           offAxisFraction: -0.5,
        //           list: listKg,
        //           onSelectedItemChanged: (index) {
        //             indexKgCurrent = index;
        //             setState(() {
        //               weightCurrent = double.parse(listKg[indexKgCurrent]) +
        //                   double.parse("0.${listGram[indexGramCurrent]}");
        //             });
        //           },
        //         ),
        //       ),
        //       // Expanded(child: const Text("cm"))
        //       Expanded(
        //         child: CupertinoPickerWidget(
        //           capStartEdge: false,
        //           capEndEdge: false,
        //           initialItem: indexGramCurrent,
        //           list: listGram,
        //           prefixText: ".",
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           padding: const EdgeInsets.only(right: 20),
        //           onSelectedItemChanged: (index) {
        //             indexGramCurrent = index;
        //             setState(() {
        //               weightCurrent = double.parse(listKg[indexKgCurrent]) +
        //                   double.parse("0.${listGram[indexGramCurrent]}");
        //             });
        //           },
        //         ),
        //       ),
        //       Expanded(
        //         flex: 2,
        //         child: CupertinoPickerWidget(
        //           capStartEdge: false,
        //           initialItem: 0,
        //           list: ["kg"],
        //           padding: const EdgeInsets.only(left: 20),
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           onSelectedItemChanged: (index) {},
        //         ),
        //       )
        //     ],
        //   ),
        // );
      }

      return LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // width: MediaQuery.of(context).size.width,
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff161B31),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            __itemInfo(
                                title: "Tên người dùng",
                                value: "Như Như",
                                checkSelection: false,
                                onTap: () {}),
                            __itemInfo(
                                title: "Giới tính",
                                value: listGender[indexGenderCurrent],
                                valueEnumItemEdit: EnumItemEdit.GENDER,
                                onTap: () {
                                  onTapItem(EnumItemEdit.GENDER);
                                }),
                            if (enumItemEdit == EnumItemEdit.GENDER)
                              __genderPickerWidget(),
                            __itemInfo(
                                title: "Sinh nhật",
                                value: DateFormat("dd/MM/yyyy")
                                    .format(dateTimeBirthday),
                                valueEnumItemEdit: EnumItemEdit.BIRTHDAY,
                                onTap: () {
                                  onTapItem(EnumItemEdit.BIRTHDAY);
                                }),
                            if (enumItemEdit == EnumItemEdit.BIRTHDAY)
                              SizedBox(
                                height: 200,
                                child: CupertinoTheme(
                                  data: CupertinoTheme.of(context).copyWith(
                                    textTheme: CupertinoTheme.of(context)
                                        .textTheme
                                        .copyWith(
                                          dateTimePickerTextStyle:
                                              CupertinoTheme.of(context)
                                                  .textTheme
                                                  .dateTimePickerTextStyle
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                          // textStyle:  const TextStyle(color: Colors.white),
                                        ),
                                  ),
                                  child: CupertinoDatePicker(
                                    initialDateTime: dateTimeBirthday,
                                    mode: CupertinoDatePickerMode.date,
                                    dateOrder: DatePickerDateOrder.dmy,
                                    // This is called when the user changes the date.
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(
                                          () => dateTimeBirthday = newDate);
                                    },
                                  ),
                                ),
                              ),
                            __itemInfo(
                                title: "Chiều cao",
                                value: "${heightCurrent.toString()} cm",
                                valueEnumItemEdit: EnumItemEdit.HEIGHT,
                                onTap: () {
                                  onTapItem(EnumItemEdit.HEIGHT);
                                }),
                            if (enumItemEdit == EnumItemEdit.HEIGHT)
                              __heightPickerWidget(),
                            __itemInfo(
                                title: "Trọng lượng cơ thể",
                                value: weightCurrent.toString(),
                                valueEnumItemEdit: EnumItemEdit.WEIGHT,
                                onTap: () {
                                  onTapItem(EnumItemEdit.WEIGHT);
                                }),
                            if (enumItemEdit == EnumItemEdit.WEIGHT)
                              __weightPickerWidget(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  )),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      appBar: _appbar(),
      body: _body(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

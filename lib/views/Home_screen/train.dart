// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/consts/consts.dart';

import '../../common_widgets/boxWidget.dart';
import '../../common_widgets/radioButton.dart';
import '../../consts/images.dart';
import '../../model/user_model.dart'; // Importing images file again (redundant)

// Define a Train class which is a StatelessWidget
class Train extends StatefulWidget {
  const Train({super.key});

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  // Constructor

  bool _isVisible = false;
  final List trainList = [
    atHomeNo,
    atGym,
    outDoor,
    atHomeYes,
  ];

  int value = 0;
  int valueOne = 0;
  final List<TextModel> atHomeDataNo = [
    TextModel(
        title: '\n\nChest Workout:\n\n',
        subTitle:
            'Push-Ups\n\n 3 sets of 10-15 reps\nIncline Push-Ups (using a sturdy elevated surface like a chair or table)\n\n3 sets of 10-15 reps\nWide Arm Push-Ups\n\n3 sets of 10-15 reps.'),
    TextModel(
        title: '\n\nBack Workout:\n\n',
        subTitle:
            'Bodyweight Rows (using a sturdy horizontal bar or table edge)\n\n3 sets of 10-15 reps\nSuperman Exercise\n\n3 sets of 10-15 reps\nReverse Snow Angels (lying face down, arms extended overhead)\n\n3 sets of 10-15 reps'),
    TextModel(
        title: '\n\nLegs Workout:\n\n',
        subTitle:
            'Bodyweight Squats\n\n3 sets of 15-20 reps\nLunges (alternating legs)\n\n3 sets of 10-12 reps per leg\nGlute Bridges\n\n3 sets of 15-20 reps'),
  ];

  final List<TextModel> atGymData = [
    TextModel(
        title: '\n\nChest Workout:\n\n',
        subTitle:
            'Bench Press\n\n 3 sets x 8-10 reps\n Incline Dumbbell Press\n\n 3 sets x 10-12 reps\n Chest Flyes (Machine or Dumbbells)\n\n 3 sets x 12-15 reps\n Push-Ups (Optional - for bodyweight variation)\n\n 3 sets x failure (as many reps as possible)'),
    TextModel(
        title: '\n\nBack Workout:\n\n',
        subTitle:
            'Pull-Ups or Lat Pulldowns\n\n 3 sets x 8-10 reps\n Barbell Rows\n\n 3 sets x 8-10 reps\n Single-Arm Dumbbell Rows\n\n 3 sets x 10-12 reps per arm\n Hyperextensions or Good Mornings\n\n 3 sets x 12-15 reps'),
    TextModel(
        title: '\n\nLegs Workout:\n\n',
        subTitle:
            'Squats\n\n 4 sets x 8-10 reps\n Romanian Deadlifts\n\n 3 sets x 8-10 reps\n Leg Press\n\n 3 sets x 10-12 reps\n Leg Curls\n\n 3 sets x 12-15 reps\n Calf Raises\n\n 3 sets x 15-20 reps'),
  ];

  final List<TextModel> outdoorData = [
    TextModel(
        title: '\n\nChest Workout:\n\n',
        subTitle:
            'Push-Ups:\n3 sets of 10-15 repetitions\n Bench Dips (using a sturdy bench or elevated surface): 3 sets of 10-12 repetitions\n Incline Push-Ups (using a raised surface like a bench or sturdy platform): 3 sets of 8-12 repetitions'),
    TextModel(
        title: '\n\nBack Workout:\n\n',
        subTitle:
            'Pull-Ups (if available): 3 sets of as many repetitions as possible\n Bent-Over Rows (using resistance bands or a backpack filled with weights or objects): 3 sets of 10-12 repetitions\n Superman Exercise:\n3 sets of 12-15 repetitions'),
    TextModel(
        title: '\n\nLegs Workout:\n\n',
        subTitle:
            'Sprints:\n5 sets of 20 seconds\n Lunges:\n3 sets of 10-12 repetitions per leg\n Step-Ups (using a sturdy bench or elevated surface): 3 sets of 10-12 repetitions per leg\n\n '),
  ];

  final List<TextModel> atHomeData = [
    TextModel(
      title: '\n\nChest Workout:\n\n',
      subTitle:
          'Barbell Bench Press\n\n 3 sets x 8-10 reps\n Dumbbell Flyes\n\n 3 sets x 10-12 reps\n Push-Ups\n\n 3 sets to failure (or as many reps as possible)',
    ),
    TextModel(
        title: '\n\nBack Workout:\n\n',
        subTitle:
            'Bent Over Barbell Rows\n\n 3 sets x 8-10 reps\n Pull-Ups or Assisted Pull-Ups\n\n 3 sets x 6-8 reps\n Dumbbell Single-Arm Rows\n\n 3 sets x 10-12 reps per arm'),
    TextModel(
        title: '\n\nLegs Workout:\n\n',
        subTitle:
            'Squats (with barbell or dumbbells)\n\n 3 sets x 8-10 reps\n Romanian Deadlifts\n\n 3 sets x 10-12 reps\n Lunges (with dumbbells)\n\n 3 sets x 10-12 reps per leg'),
  ];
  bool isLoading = true;
  List<AddUserModel> user = [];
  Future<void> getUser() async {
    try {
      // Clear the user list and update the UI
      user.clear();

      // Open the SQLite database
      Database database = await openDatabase(
        join(await getDatabasesPath(), 'your_database.db'),
        version: 1,
      );

      // Query the database to retrieve the user profile
      List<Map<String, dynamic>> userRows = await database.query(
        'users',
        where: 'doc = ?',
        whereArgs: [StaticInfo.docId.toString()],
      );

      // Process the retrieved user data
      for (int i = 0; i < userRows.length; i++) {
        AddUserModel dataModel = AddUserModel.fromJson(userRows[i]);
        user.add(dataModel);
      }

      // Close the database
      await database.close();

      // Calculate total calories
      setState(() {
        isLoading = false;


      });

      // Print the name of the user
      if (user.isNotEmpty) {
        print('Name: ${user[0].name}');
      }
    } catch (e) {
      // Handle any errors
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
        isLoading?Center(child: const CircularProgressIndicator()):ListView(
          children: [
            (context.screenHeight * 0.04).heightBox,
            // Widget to add vertical space
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    train.text.size(25).fontFamily(bold).make(),
                    const SizedBox(
                      width: 10,
                    ),
                    user[0].goals!.text
                        .size(15)
                        .fontFamily(semibold)
                        .make()

                  ],
                ), // Widget to display text
              ),
            ),
            (context.screenHeight * 0.02).heightBox,
            // Widget to add vertical space

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  trainList.length,
                  (index) => StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Column(
                        children: [
                          // Widget to display a BoxWidget with a title and icon
                          BoxWidget(
                            title: trainList[index].toString(),
                            icon: (icArrow),
                            width: (context.screenWidth - 40),
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            onTapText: () {
                              setState(() {
                                _isVisible = false;
                              });
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    15,
                                    index == 0
                                        ? MediaQuery.sizeOf(context).height *
                                            0.23
                                        : index == 1
                                            ? MediaQuery.sizeOf(context)
                                                    .height *
                                                0.33
                                            : index == 2
                                                ? MediaQuery.sizeOf(context)
                                                        .height *
                                                    0.43
                                                : MediaQuery.sizeOf(context)
                                                        .height *
                                                    0.53,
                                    0,
                                    10),
                                items: <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'option1',
                                    child: Text('Chest'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'option2',
                                    child: Text('Back'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'option3',
                                    child: Text('Legs'),
                                  ),
                                ],
                                elevation: 8.0,
                              ).then((value) {
                                if (value != null) {
                                  print('Selected option: $value');
                                }
                              });
                            },
                            requireWidget: Visibility(
                              visible: _isVisible,
                              child: index == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ...List.generate(
                                          atHomeDataNo.length,
                                          (index) => RichText(
                                            text: TextSpan(
                                                text: atHomeDataNo[index].title,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text: atHomeDataNo[index]
                                                          .subTitle,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 91.30,
                                              height: 25.60,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 0.55,
                                                      color: Color(0xFFA6A8B7)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.30),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          value >= 1
                                                              ? value -= 1
                                                              : value = 0;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      )),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    width: 1,
                                                    color: Color(0xFFA6A8B7),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${value} Rep',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff484848),
                                                        fontSize: 11),
                                                  ),
                                                  const Spacer(),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    width: 1,
                                                    color: Color(0xFFA6A8B7),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          value += 1;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: 91.30,
                                              height: 25.60,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 0.55,
                                                      color: Color(0xFFA6A8B7)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.30),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          valueOne >= 1
                                                              ? valueOne -= 1
                                                              : valueOne = 0;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      )),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    width: 1,
                                                    color: Color(0xFFA6A8B7),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${valueOne} Set',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff484848),
                                                        fontSize: 11),
                                                  ),
                                                  const Spacer(),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    width: 1,
                                                    color: Color(0xFFA6A8B7),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          valueOne += 1;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : index == 1
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ...List.generate(
                                              atGymData.length,
                                              (index) => RichText(
                                                text: TextSpan(
                                                    text:
                                                        atGymData[index].title,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    children: [
                                                      TextSpan(
                                                          text: atGymData[index]
                                                              .subTitle,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))
                                                    ]),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 91.30,
                                                  height: 25.60,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  decoration: ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 0.55,
                                                          color: Color(
                                                              0xFFA6A8B7)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.30),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              value >= 1
                                                                  ? value -= 1
                                                                  : value = 0;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          )),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                        width: 1,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${value} Rep',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff484848),
                                                            fontSize: 11),
                                                      ),
                                                      const Spacer(),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                        width: 1,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              value += 1;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: 91.30,
                                                  height: 25.60,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  decoration: ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 0.55,
                                                          color: Color(
                                                              0xFFA6A8B7)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.30),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              valueOne >= 1
                                                                  ? valueOne -=
                                                                      1
                                                                  : valueOne =
                                                                      0;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          )),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                        width: 1,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${valueOne} Set',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff484848),
                                                            fontSize: 11),
                                                      ),
                                                      const Spacer(),
                                                      const VerticalDivider(
                                                        thickness: 1,
                                                        width: 1,
                                                        color:
                                                            Color(0xFFA6A8B7),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              valueOne += 1;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : index == 2
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ...List.generate(
                                                  outdoorData.length,
                                                  (index) => RichText(
                                                    text: TextSpan(
                                                        text: outdoorData[index]
                                                            .title,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        children: [
                                                          TextSpan(
                                                              text: outdoorData[
                                                                      index]
                                                                  .subTitle,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 91.30,
                                                      height: 25.60,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: const BorderSide(
                                                              width: 0.55,
                                                              color: Color(
                                                                  0xFFA6A8B7)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  value >= 1
                                                                      ? value -=
                                                                          1
                                                                      : value =
                                                                          0;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            '${value} Rep',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff484848),
                                                                fontSize: 11),
                                                          ),
                                                          const Spacer(),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  value += 1;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      width: 91.30,
                                                      height: 25.60,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: const BorderSide(
                                                              width: 0.55,
                                                              color: Color(
                                                                  0xFFA6A8B7)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  valueOne >= 1
                                                                      ? valueOne -=
                                                                          1
                                                                      : valueOne =
                                                                          0;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            '${valueOne} Set',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff484848),
                                                                fontSize: 11),
                                                          ),
                                                          const Spacer(),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  valueOne += 1;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ...List.generate(
                                                  atHomeData.length,
                                                  (index) => RichText(
                                                    text: TextSpan(
                                                        text: atHomeData[index]
                                                            .title,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        children: [
                                                          TextSpan(
                                                              text: atHomeData[
                                                                      index]
                                                                  .subTitle,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 91.30,
                                                      height: 25.60,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: const BorderSide(
                                                              width: 0.55,
                                                              color: Color(
                                                                  0xFFA6A8B7)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  value >= 1
                                                                      ? value -=
                                                                          1
                                                                      : value =
                                                                          0;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            '${value} Rep',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff484848),
                                                                fontSize: 11),
                                                          ),
                                                          const Spacer(),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  value += 1;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      width: 91.30,
                                                      height: 25.60,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: const BorderSide(
                                                              width: 0.55,
                                                              color: Color(
                                                                  0xFFA6A8B7)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  valueOne >= 1
                                                                      ? valueOne -=
                                                                          1
                                                                      : valueOne =
                                                                          0;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            '${valueOne} Set',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff484848),
                                                                fontSize: 11),
                                                          ),
                                                          const Spacer(),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            width: 1,
                                                            color: Color(
                                                                0xFFA6A8B7),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  valueOne += 1;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xFFA6A8B7),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                            ),
                          ),
                          20.heightBox,
                          // Widget to add vertical space
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ).box.make(), // Wrapping the Column in a Box and making it
      ),
    );
  }
}

class TextModel {
  String title;
  String subTitle;

  TextModel({required this.title, required this.subTitle});
}

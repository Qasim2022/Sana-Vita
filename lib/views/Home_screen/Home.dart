import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/Home_screen/dialog/dialogForCalender.dart';
import 'package:untitled/views/workout_screens/goalsScreen.dart';
import 'package:untitled/views/workout_screens/workoutScreen.dart';

import '../../model/user_model.dart';
import 'dialog/dialog_for_dataCollection.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<SharedPreferences> _prefs;
  late SharedPreferences prefs;
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

        if (user.isNotEmpty) {
          if (user[0].goals == "Lose Weight" && user[0].experience == "Beginner") {
            calculatedCalories = 1600;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Lose Weight" && user[0].experience == "Intermediate") {
            calculatedCalories = 1400;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Lose Weight" && user[0].experience == "Advance") {
            calculatedCalories = 1200;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Maintain Weight" && user[0].experience == "Beginner") {
            calculatedCalories = 1900;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Maintain Weight" && user[0].experience == "Intermediate") {
            calculatedCalories = 1900;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Maintain Weight" && user[0].experience == "Advanced") {
            calculatedCalories = 1700;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Gain Weight" && user[0].experience == "Beginner") {
            calculatedCalories = 2200;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Gain Weight" && user[0].experience == "Intermediate") {
            calculatedCalories = 2400;
            print("calculatedCalories = ${calculatedCalories}");
          } else if (user[0].goals == "Gain Weight" && user[0].experience == "Advanced") {
            calculatedCalories = 2600;
            print("calculatedCalories = ${calculatedCalories}");
          }
        }
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

    initPrefs();
    _prefs = SharedPreferences.getInstance();
    getUser();
  }

  TextEditingController feelingsController = TextEditingController();

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // Load the saved text from SharedPreferences and display it
    String savedFeelings = prefs.getString('feelings') ?? '';
    setState(() {
      feelingsController.text = savedFeelings;
    });
  }

  int? collectedData;
  void collectData(int data) {
    setState(() {
      collectedData = data;
    });
  }

  int calculatedCalories = 0;

  void updateStreak(SharedPreferences prefs) {
    if (prefs.containsKey('lastDate')) {
      DateTime? lastDate = DateTime.tryParse(prefs.getString('lastDate') ?? '');

      DateTime currentDate = DateTime.now();
      int streak = prefs.getInt('streak') ?? 0;

      if (lastDate != null) {
        // Check if the last date is yesterday
        if (lastDate.year == currentDate.year &&
            lastDate.month == currentDate.month &&
            lastDate.day == currentDate.day - 1) {
          streak++; // Increment streak if opened consecutively
        } else {
          streak = 0; // Reset streak if missed a day
        }
      }

      prefs.setInt('streak', streak);
      prefs.setString('lastDate', currentDate.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    int remainingCalories = calculatedCalories - (collectedData ?? 0);
    return Scaffold(
      backgroundColor: lightGrey,
      body: FutureBuilder<SharedPreferences>(
        future: _prefs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            SharedPreferences prefs = snapshot.data!;
            updateStreak(prefs); // Update streak after prefs are initialized

            // Check if user data is available
            if (isLoading) {
              // Render loading indicator until data is fetched
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Render the home screen with fetched user data
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: skyColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          (context.screenHeight * 0.02).heightBox,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: "Welcome ${user[0].name}"
                                  .text
                                  .color(Colors.white)
                                  .fontFamily(semibold)
                                  .size(22)
                                  .make(),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(homeCalenderBackground),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Streak: ${prefs.getInt('streak') ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogForCalender();
                                        },
                                      );
                                    },
                                    child: Image.asset(calender),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.heightBox,
                    Column(
                      children: [
                        20.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Calories".text.size(18).fontFamily(bold).make(),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogForData(
                                        collectData: collectData,
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(icAdd),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: "${user[0].goals}(${user[0].experience})"
                                .text
                                .fontFamily(semibold)
                                .make(),
                          ),
                        ),
                        25.heightBox,
                        Stack(
                          children: [
                            Image.asset(icHeart),
                            Positioned(
                              top: 20,
                              left: 45,
                              child: Column(
                                children: [
                                  5.heightBox,
                                  calculatedCalories.text
                                      .color(Colors.blue)
                                      .fontFamily(bold)
                                      .make(),
                                  "Left".text.color(Colors.grey).make(),
                                  remainingCalories.text
                                      .color(Colors.grey)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                        .box
                        .white
                        .width(context.screenWidth - 30)
                        .height(250)
                        .shadowSm
                        .rounded
                        .make(),
                    15.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: "How are you feeling"
                              .text
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: TextField(
                            controller: feelingsController,
                            onChanged: (text) {
                              // Save the text input to SharedPreferences whenever it changes
                              prefs.setString('feelings', text);
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "Write how you feel",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        .box
                        .white
                        .width(context.screenWidth - 30)
                        .shadowSm
                        .height(Get.height * .2)
                        .rounded
                        .make(),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

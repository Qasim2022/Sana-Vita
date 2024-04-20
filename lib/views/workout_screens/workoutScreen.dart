import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common_widgets/workoutfield.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/workout_screens/goalsScreen.dart';

import '../../common_widgets/buttonWidget.dart';
import '../../consts/colors.dart';
import '../../model/user_model.dart';

// Define a StatefulWidget for the WorkoutScreen
int selected = 0; // Variable to keep track of selected workout level
class WorkoutScreen extends StatefulWidget {
  final AddUserModel userData; // AddUserModel instance to receive data

  const WorkoutScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  final List<String> workoutLevelTitles = ['Beginner', 'Intermediate', 'Advance'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGrey, // Set background color
        body: SingleChildScrollView(

          child: Column(
            children: [
              (context.screenHeight * 0.048).heightBox, // Widget to add vertical space
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: oftenWorkout.text.fontFamily(semibold).size(22).make(), // Widget to display text
                ),
              ),
              (context.screenHeight * 0.05).heightBox, // Widget to add vertical space
              Column(
                children: [
                  // Widget to display workout fields with different levels
                  WorkoutField(
                    title: beginner,
                    subTitle: startingWorkout,
                    width: (context.screenWidth * 0.85),
                    selected: selected == 1, // Set selected based on current state
                    onTap: () {
                      setState(() {
                        selected = 1; // Update selected state when tapped
                      });
                    },
                  ),
                  20.heightBox, // Widget to add vertical space
                  WorkoutField(
                    title: inter,
                    subTitle: timesWeek1,
                    width: (context.screenWidth * 0.85),
                    selected: selected == 2, // Set selected based on current state
                    onTap: () {
                      setState(() {
                        selected = 2; // Update selected state when tapped
                      });
                    },
                  ),
                  20.heightBox, // Widget to add vertical space
                  WorkoutField(
                    title: advance,
                    subTitle: timesWeek3,
                    width: (context.screenWidth * 0.85),
                    selected: selected == 3, // Set selected based on current state
                    onTap: () {
                      setState(() {
                        selected = 3; // Update selected state when tapped
                      });
                    },
                  ),
                  (context.screenHeight * 0.33).heightBox, // Widget to add vertical space
                  // Widget to display next button
                  ButtonWidget(
                    disabled: selected == 0, // Disable button if no workout level is selected
                    title: next,
                    color: skyColor,
                    onPress: () {
              if (selected != 0) {
                widget.userData.experience = workoutLevelTitles[selected - 1];
                Get.to(() => RadioButtonsPage(userData: widget.userData));
              print('Selected workout level: ${workoutLevelTitles[selected - 1]}');
              } else {
              print('No workout level selected');
              }
          
                     // print(widget.userData.weight);
                      // Pass userData to the next screen
                     // Get.to(() => RadioButtonsPage(userData: widget.userData));
                    },
                  ).box.width(context.screenWidth - 55).make(), // Widget to adjust button width
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

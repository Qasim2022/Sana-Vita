import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/strings.dart';
import 'package:untitled/views/workout_screens/likeTrain.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../common_widgets/buttonWidget.dart';
import '../../common_widgets/radioButton.dart';
import '../../consts/colors.dart';
import '../../consts/styles.dart';
import '../controllers/radioController.dart';
import '../../model/user_model.dart'; // Import the user model

// Define a StatelessWidget for the radio buttons page

final RadioController radioController = Get.put(RadioController());

class RadioButtonsPage extends StatefulWidget {
  final AddUserModel userData; // Define userData parameter

  // Constructor to receive the userData parameter
  RadioButtonsPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<RadioButtonsPage> createState() => _RadioButtonsPageState();
}

class _RadioButtonsPageState extends State<RadioButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey, // Set background color
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            // Widget to add vertical space
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: yourGoals.text
                    .size(24)
                    .fontFamily(bold)
                    .make(), // Widget to display text
              ),
            ),
            (context.screenHeight * 0.05).heightBox,
            // Widget to add vertical space
            // Widget to display radio buttons for different goals
            Obx(() => RadioButtonWidget(
                title: loseWt,
                value: loseWt,
                groupValue: radioController.selectedGoal.value,
                onChanged: (val) {
                  radioController.selectOption(radioController.selectedGoal,
                      val); // Function to handle radio button selection
                })),
            Obx(() => RadioButtonWidget(
                title: maintainWt,
                value: maintainWt,
                groupValue: radioController.selectedGoal.value,
                onChanged: (val) {
                  radioController.selectOption(radioController.selectedGoal,
                      val); // Function to handle radio button selection
                })),
            Obx(() => RadioButtonWidget(
                title: gainWt,
                value: gainWt,
                groupValue: radioController.selectedGoal.value,
                onChanged: (val) {
                  radioController.selectOption(radioController.selectedGoal,
                      val); // Function to handle radio button selection
                })),
            Spacer(),
            // Widget to occupy available space
            // Widget to display next button
            ButtonWidget(
                title: next,
                color: skyColor,
                onPress: () {
                  widget.userData.goals = radioController.selectedGoal.value;
                  print(radioController.selectedGoal.value);
                  Get.to(() => LiketoTrainScreen(
                      userData: widget
                          .userData)); // Navigate to LiketoTrainScreen with userData
                }).box.width(context.screenWidth - 50).make(),
            // Widget to adjust button width
            (context.screenHeight * 0.06).heightBox,
            // Widget to add vertical space
          ],
        ),
      ),
    );
  }
}

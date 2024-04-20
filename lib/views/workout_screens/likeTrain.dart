import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common_widgets/radioButton.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/workout_screens/bestSuited.dart';
import '../../common_widgets/buttonWidget.dart';
import '../../consts/colors.dart';
import '../../model/user_model.dart';
import '../controllers/radioController.dart';
import 'goalsScreen.dart';

// Define a StatelessWidget for the LiketoTrainScreen
class LiketoTrainScreen extends StatefulWidget {
  final AddUserModel userData; // Define userData parameter
  LiketoTrainScreen({Key? key, required this.userData}) : super(key: key);
  @override
  State<LiketoTrainScreen> createState() => _LiketoTrainScreenState();
}

class _LiketoTrainScreenState extends State<LiketoTrainScreen> {
  final RadioController radioController = Get.put(RadioController());
 // Initialize RadioController
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey, // Set background color
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox, // Widget to add vertical space
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: likeToTrain.text.size(24).fontFamily(bold).make(), // Widget to display text
              ),
            ),
            (context.screenHeight*0.05).heightBox, // Widget to add vertical space
            // Widget to display radio buttons for different training locations
            Obx(() => RadioButtonWidget(
                title: atHome,
                value: atHome,
                groupValue: radioController.selectedLocation.value,
                onChanged: (val){
                  radioController.selectOption(radioController.selectedLocation, val); // Function to handle radio button selection
                }
            )),
            Obx(() => RadioButtonWidget(
                title: atGym,
                value: atGym,
                groupValue: radioController.selectedLocation.value,
                onChanged: (val){
                  radioController.selectOption(radioController.selectedLocation, val); // Function to handle radio button selection
                }
            )),
            Obx(() => RadioButtonWidget(
                title: outDoor,
                value: outDoor,
                groupValue: radioController.selectedLocation.value,
                onChanged: (val){
                  radioController.selectOption(radioController.selectedLocation, val); // Function to handle radio button selection
                }
            )),
            Obx(() => RadioButtonWidget(
                title: atHomeWt,
                value: atHomeWt,
                groupValue: radioController.selectedLocation.value,
                onChanged: (val){
                  radioController.selectOption(radioController.selectedLocation, val); // Function to handle radio button selection
                }
            )),
            Spacer(), // Widget to occupy available space
            // Widget to display next button
            ButtonWidget(
                title: next,
                color: skyColor,
                onPress:(){
                  widget.userData.trainPlace = radioController.selectedGoal.value;
                  print(radioController.selectedLocation.value);
                  Get.to(()=>BestSuitedScreen(userData: widget.userData,)); // Navigate to BestSuitedScreen when next button is pressed
                }
            ).box.width(context.screenWidth-50).make(), // Widget to adjust button width
            (context.screenHeight*0.06).heightBox, // Widget to add vertical space
          ],
        ),
      ),
    );
  }
}

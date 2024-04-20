// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/images.dart';
import 'package:untitled/consts/strings.dart';

import '../../common_widgets/buttonWidget.dart';
import '../../consts/colors.dart';
import '../auth_screen/loginScreen.dart';


// Define a WelcomeScreen StatelessWidget
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashScreenColor, // Set background color
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: Get.height,
          child: Column(
            children: [
              Spacer(), // Widget to occupy available space
              Text( // Widget to display text
                "Welcome to Sana Vita",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              Spacer(), // Widget to occupy available space
              Image.asset(welcome), // Widget to display image
              Spacer(), // Widget to occupy available space
              Text(
                lorem, // Widget to display text
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(), // Widget to occupy available space
              Container(
                width: Get.width*.9,
                child: ButtonWidget( // Widget to display custom button
                  title: getStart,
                  color: skyColor,
                  onPress: (){
                    Get.to(()=>LoginScreen()); // Navigate to LoginScreen
                  },
                  textColor: whiteColor,
                ),
              ),
              SizedBox(height: Get.height*.05,), // Widget to add vertical space
            ],
          ),
        ),
      ),
    );
  }
}

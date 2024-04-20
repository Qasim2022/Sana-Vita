// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importing GetX package
import 'package:untitled/views/splashScreen/welcomeScreen.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../auth_screen/loginScreen.dart';

// Define a SplashScreen StatefulWidget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Define the state for SplashScreen widget
class _SplashScreenState extends State<SplashScreen> {
  // Method to change the screen after a delay
  changeScreen(){
    // Delay the screen change using Future.delayed
    Future.delayed(Duration(seconds: 5),(){
      // Navigate to WelcomeScreen using GetX
      Get.to(()=>WelcomeScreen());
    });
  }

  @override
  void initState() {
    // Call the method to change screen when the state is initialized
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: splashScreenColor, // Set background color
        body: Center(child: Image.asset(imgSplash,width: Get.width*.5)) // Display splash image in the center
    );
  }
}

// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/Home_screen/Home.dart';
import 'package:untitled/views/Home_screen/diet.dart';
import 'package:untitled/views/Home_screen/profile.dart';
import 'package:untitled/views/Home_screen/train.dart';

import '../controllers/homeController.dart';

// Define a HomeScreen class which is a StatelessWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController()); // Getting the instance of HomeController
    var navBarItem = [
      // List of BottomNavigationBarItem for navigation bar
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 28,),
          activeIcon: Image.asset(icHome, color: skyColor, width: 28,),
          label: "Home"
      ),
      BottomNavigationBarItem(
          activeIcon: Image.asset(icDiet, color: skyColor, width: 28,),
          icon: Image.asset(icDiet, width: 28,),
          label: "Diet"
      ),
      BottomNavigationBarItem(
          activeIcon: Image.asset(icTrain, color: skyColor, width: 28,),
          icon: Image.asset(icTrain, width: 28,),
          label: "Train"
      ),
      BottomNavigationBarItem(
          activeIcon: Image.asset(icProfile, color: skyColor, width: 28,),
          icon: Image.asset(icProfile, width: 28,),
          label: "Profile"
      ),
    ];

    var navBarBody = [
      // List of widget bodies for navigation bar items
      const Home(),
      const Diet(),
      const Train(),
      const Profile(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGrey, // Background color set to light grey
        body: Obx(() => navBarBody.elementAt(controller.currentNavIndex.value)), // Observe and show the body based on current navigation index
        bottomNavigationBar: Obx(() => // Observe and update the bottom navigation bar
        Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 1
                )
              ],
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: controller.currentNavIndex.value, // Current index of the navigation bar
            selectedItemColor: skyColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold), // Style for selected label
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value; // Update the current navigation index on tap
            },
          ).box.white.roundedFull.make(), // Styling the bottom navigation bar
        ),
        ),
      ),
    );
  }
}

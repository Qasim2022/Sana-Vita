// Import necessary packages and files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' ;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/consts/colors.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/auth_screen/loginScreen.dart';

import '../../common_widgets/buttonWidget.dart';
import '../../common_widgets/radioButton.dart';
import '../../model/user_model.dart';
import '../Home_screen/homeScreen.dart';
import '../controllers/radioController.dart'; // Importing RadioController
import 'goalsScreen.dart';

// Define a BestSuitedScreen StatelessWidget
class BestSuitedScreen extends StatefulWidget {
  final AddUserModel userData;
  const BestSuitedScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<BestSuitedScreen> createState() => _BestSuitedScreenState();
}

class _BestSuitedScreenState extends State<BestSuitedScreen> {

 // Define userData parameter

  final RadioController radioController = Get.put(RadioController());
 // Initialize RadioController
  ///TextEditingController dietController = TextEditingController();
  bool isLoading = false;
  Future<void> registerUser(String diet) async {
    isLoading = true; // Assuming isLoading is declared outside this function
    int id = DateTime.now().millisecondsSinceEpoch;

    // Open the database
    final database = openDatabase(
      join(await getDatabasesPath(), 'your_database.db'),
      onCreate: (db, version) {
        // Create the users table
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, email TEXT UNIQUE, password TEXT, age INTEGER, gender TEXT, height REAL, weight REAL, experience TEXT, goals TEXT, trainPlace TEXT, diet TEXT, doc TEXT)",
        );
      },
      version: 1,
    );

    try {
      final db = await database;

      // Check if email already exists
      List<Map<String, dynamic>> existingUsers = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [widget.userData.email],
      );

      if (existingUsers.isNotEmpty) {
        isLoading = false;
        Fluttertoast.showToast(msg: 'This email is already registered. Please try another email.');
        return;
      }

      // Insert the user data into the users table
      await db.insert(
        'users',
        {
          'name': widget.userData.name,
          'email': widget.userData.email,
          'password': widget.userData.password,
          'age': widget.userData.age,
          //  'gender': widget.userData.gender,
          'height': widget.userData.height,
          'weight': widget.userData.weight,
          'experience': widget.userData.experience,
          'goals': widget.userData.goals,
          'trainPlace': widget.userData.trainPlace,
          'diet': diet.toString(),
          'doc': id.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      isLoading = false;
      registerUse(diet.toString());
      Fluttertoast.showToast(msg: 'Account created successfully');
      Get.offAll(() => LoginScreen());

    } catch (e) {
      print(e.toString());
      isLoading = false;
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }


  registerUse(String diet) async {
    //isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    AddUserModel dataModel = AddUserModel(
      name: widget.userData.name,
      email: widget.userData.email,
      password:widget.userData.password,
      age: widget.userData.age,
     // gender: widget.userData.gender,
      height: widget.userData.height,
      weight: widget.userData.weight,
      experience:widget.userData.experience,
      goals: widget.userData.goals,
      trainPlace: widget.userData.trainPlace,
      diet: diet.toString(),
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc('$id')
          .set(dataModel.toJson());
     // isLoading = false;
      setState(() {});
     // Fluttertoast.showToast(msg: 'account created successfully');
    //  Get.offAll(() =>  LoginScreen());


    } catch (e) {
      //isLoading = false;
      setState(() {});
     // Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }
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
                child: dietSuited.text.size(24).fontFamily(bold).make(), // Widget to display text
              ),
            ),
            (context.screenHeight*0.05).heightBox, // Widget to add vertical space
            // Widget to display radio buttons with different diet options
            Obx(() => RadioButtonWidget(
              title: noDiet,
              value: noDiet,
              groupValue: radioController.selectedDiet.value,
              onChanged: (val) {
                radioController.selectOption(radioController.selectedDiet, val); // Function to handle radio button selection
              },
            )),
            Obx(() => RadioButtonWidget(
              title: lowCrab,
              value: lowCrab,
              groupValue: radioController.selectedDiet.value,
              onChanged: (val) {
                radioController.selectOption(radioController.selectedDiet, val); // Function to handle radio button selection
              },
            )),
            Obx(() => RadioButtonWidget(
              title: highProtein,
              value: highProtein,
              groupValue: radioController.selectedDiet.value,
              onChanged: (val) {
                radioController.selectOption(radioController.selectedDiet, val); // Function to handle radio button selection
              },
            )),
            Obx(() => RadioButtonWidget(
              title: ketoDiet,
              value: ketoDiet,
              groupValue: radioController.selectedDiet.value,
              onChanged: (val) {
                radioController.selectOption(radioController.selectedDiet, val); // Function to handle radio button selection
              },
            )),
            const Spacer(), // Widget to occupy available space
            // Widget to display next button
            isLoading?const Center(child: CircularProgressIndicator()):
            ButtonWidget(
              title: next,
              color: skyColor,
              onPress: () {
                registerUser(radioController.selectedDiet.value);
                print(radioController.selectedDiet.value);
               //  // Navigate to HomeScreen
              },
            ).box.width(context.screenWidth-50).make(), // Widget to adjust button width
            (context.screenHeight*0.06).heightBox, // Widget to add vertical space
          ],
        ),
      ),
    );
  }
}

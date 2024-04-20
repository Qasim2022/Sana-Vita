import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/common_widgets/buttonWidget.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/auth_screen/signupScreen.dart';
import 'package:path/path.dart' ;

import '../../common_widgets/custom_textformfield.dart';
import '../../consts/colors.dart';
import '../Home_screen/homeScreen.dart';
import '../workout_screens/aboutYou.dart';


// Screen for user login
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isVisible=true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();
  Future<void> userLogin() async {
     isLoading = true;
    int id;
    String userName;
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'your_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, age INTEGER, gender TEXT, height REAL, weight REAL, experience TEXT, goals TEXT, trainPlace TEXT, diet TEXT, doc TEXT)",
        );
      },
      version: 1,
    );

    try {
      final db = await database;
      // Query the database to check if the user exists with the provided email
      List<Map<String, dynamic>> userRows = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [emailController.text.toLowerCase()],
      );

      if (userRows.isNotEmpty) {
        // If the user exists, check if the password matches
        List<Map<String, dynamic>> passwordRows = await db.query(
          'users',
          where: 'password = ?',
          whereArgs: [passwordController.text.toLowerCase()],
        );

        if (passwordRows.isNotEmpty) {
          // Retrieve user data
          id = userRows[0]['id'];
          userName = userRows[0]['name'];
          StaticInfo.docId = userRows[0]['doc'];
          print("doc is ${StaticInfo.docId}");
          isLoading = false;
          Fluttertoast.showToast(msg: 'Successfully logged in');
          Get.offAll(() => HomeScreen());
        } else {
          isLoading = false;
          Fluttertoast.showToast(msg: 'Incorrect email or password');
        }
      } else {
        isLoading = false;
        Fluttertoast.showToast(msg: 'Incorrect email or password');
      }
    } catch (e) {
      isLoading = false;
      Fluttertoast.showToast(msg: 'Some error occurred');
    } finally {
      await database.close();
      setState(() {});
    }
  }
  // userLogin() async {
  //   isLoading = true;
  //   setState(() {});
  //   //SharedPreferences preferences = await SharedPreferences.getInstance();
  //   bool userNameExists;
  //   bool passwordExists;
  //   try {
  //     var authResult = await FirebaseFirestore.instance
  //         .collection("users")
  //         .where('email', isEqualTo: emailController.text)
  //         .get();
  //     userNameExists = authResult.docs.isNotEmpty;
  //     if (userNameExists) {
  //       var authResult = await FirebaseFirestore.instance
  //           .collection("users")
  //           .where('password', isEqualTo: passwordController.text.toLowerCase())
  //           .get();
  //       passwordExists = authResult.docs.isNotEmpty;
  //       if (passwordExists) {
  //         //await preferences.setString('userName', userName.text.trim());
  //         //  await preferences.setString('password', password.text.trim());
  //         var authResult = await FirebaseFirestore.instance
  //             .collection("users")
  //             .where('email', isEqualTo: emailController.text.toLowerCase()  )
  //             .get().then((value) {
  //           value.docs.forEach((result) {
  //             print("result = ${result.data()}");
  //             StaticInfo.docId =result.data()['doc'];
  //           });
  //         });
  //         isLoading = false;
  //         setState(() {});
  //         Fluttertoast.showToast(msg: 'Successfully logged in');
  //         //NavigateToHome
  //         Get.offAll(() =>  HomeScreen());
  //       } else {
  //         isLoading = false;
  //         setState(() {});
  //         Fluttertoast.showToast(msg: 'Incorrect email or password');
  //       }
  //     } else {
  //       isLoading = false;
  //       setState(() {});
  //       Fluttertoast.showToast(msg: 'Incorrect email or password');
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     setState(() {});
  //     Fluttertoast.showToast(msg: 'Some error occurred');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightGrey,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer
                (context.screenHeight * 0.05).heightBox,
                // Login text
                Align(
                  alignment: Alignment.centerLeft,
                  child: login.text.fontFamily(semibold).color(fontBlack).size(22).make(),
                ),
                // Spacer
                40.heightBox,
                // Email text field
                CustomTextField(
                  controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a email';
                      } else if (!value.contains('@') ||
                          !value.contains('.com') ||
                          !value.contains('gmail')) {
                        return 'Invalid email';
                      } else {
                        return null;
                      }
                    },
                    title: email, hint: emailHint),
                10.heightBox,
                // Password text field
                CustomTextField(
                  controller: passwordController,
                    hide: isVisible,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? Icon(
                          Icons.visibility_off,
                          color: Colors.grey.shade700,
                        )
                            : Icon(
                          Icons.visibility,
                          color: Colors.grey.shade700,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null; // Return null if the input is valid
                    },
                    title: password, hint: passwordHint),
                20.heightBox,
                // Login button
                isLoading?Center(child: CircularProgressIndicator()):
                ButtonWidget(
                  title: login,
                  textColor: whiteColor,
                  color: skyColor,
                  onPress: () {

                    if (_formKey.currentState!.validate()) {

                      userLogin();
                    }
                    //Get.to(() => AboutYou());
                  },
                ).box.width(context.screenWidth - 55).make(),
                15.heightBox,
                // Sign up text
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: noAccount,
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        ),
                      ),
                      TextSpan(
                        text: signup,
                        style: TextStyle(
                          fontFamily: bold,
                          color: skyColor,
                        ),
                      ),
                    ],
                  ),
                ).onTap(() {
                  Get.to(() => SignupScreen());
                }),
              ],
            ).box.padding(EdgeInsets.all(20)).make(),
          ),
        ),
      ),
    );
  }
}

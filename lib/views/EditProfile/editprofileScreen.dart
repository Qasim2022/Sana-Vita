import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/model/user_model.dart';

import '../../common_widgets/buttonWidget.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../consts/colors.dart';
import '../workout_screens/aboutYou.dart';
import 'package:path/path.dart';
// Screen for editing user profile
class EditProfileScreen extends StatefulWidget {
  final AddUserModel userData; // Add this line
  const EditProfileScreen({Key? key,required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController wieghtController=TextEditingController();
  @override
  bool isLoading =false;
  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Open the SQLite database
      Database database = await openDatabase(
        join(await getDatabasesPath(), 'your_database.db'),
        version: 1,
      );

      // Create a map of the updated user data
      Map<String, dynamic> updatedData = {
        'name': nameController.text,
        'email': emailController.text,
        'password': widget.userData.password,
        'age': widget.userData.age,
        //'gender': widget.userData.gender, // Provide a valid non-null value for gender
        'height': widget.userData.height,
        'weight': wieghtController.text,
        'experience': widget.userData.experience,
        'trainPlace': widget.userData.trainPlace,
        'diet': widget.userData.diet,
        'goals': widget.userData.goals,
        // Ensure doc is not null
        'doc': StaticInfo.docId,
      };

      // Perform the update operation
      await database.update(
        'users',
        updatedData,
        where: 'doc = ?',
        whereArgs: [StaticInfo.docId],
      );

      // Close the database
      await database.close();

      // Update successful, display message
      Fluttertoast.showToast(msg: 'Profile updated successfully');

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors
      print('Error updating profile: $e');

      Fluttertoast.showToast(msg: 'Some error occurred while updating profile');

      setState(() {
        isLoading = false;
      });
    }
  }


  // updateProfile() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   print("function chlaa== ");
  //
  //
  //   AddUserModel dataModel = AddUserModel(
  //     name:  nameController.text,
  //     email:  emailController.text,
  //     password: widget.userData.password,
  //     age:  widget.userData.age,
  //     height: widget.userData.height,
  //     weight: widget.userData.weight,
  //     experience: widget.userData.experience,
  //     goals: widget.userData.goals,
  //     trainPlace: widget.userData.trainPlace,
  //     diet:  widget.userData.diet,
  //
  //
  //     doc: StaticInfo.docId,
  //
  //
  //   );
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc('${StaticInfo.docId}')
  //         .update(dataModel.toJson());
  //
  //     Fluttertoast.showToast(msg: 'updated successfully');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //
  //     Fluttertoast.showToast(msg: 'Some error occurred');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
  void initState() {
    nameController.text= widget.userData.name.toString();
    emailController.text= widget.userData.email.toString();
    wieghtController.text= widget.userData.weight.toString();
    print("${widget.userData.height}");
    print("${widget.userData.weight}");
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spacer
              (context.screenHeight * 0.05).heightBox,
              // Edit Profile title
              Align(
                alignment: Alignment.centerLeft,
                child: "Edit Profile".text.fontFamily(semibold).size(22).make(),
              ),
              // Spacer
              40.heightBox,
              // Name text field
              CustomTextField(
                controller: nameController,

                  title: name, hint: nameHint),
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
              CustomTextField(
                  type: TextFieldType.number,
                  controller: wieghtController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a weight';
                    }
                    try {
                      int weight = int.parse(value);
                      if (weight > 200) {
                        return 'Not more than 200';
                      }
                      else if (weight < 30) {
                        return 'Not less than 30';
                      }
                    } catch (e) {
                      return 'Only digits allowed';
                    }
                    return null; // Return null if the input is valid
                  },
                  title: "Weight", hint: "Enter Weight"),
              // Old password text field

              // Confirm password text field

              // Spacer
              20.heightBox,
              // Save button
              isLoading?Center(child: CircularProgressIndicator()):
              ButtonWidget(
                title: save,
                color: skyColor,
                onPress: () {
                  if (_formKey.currentState!.validate()) {

                    updateProfile();
                  }

                 // Get.to(() => AboutYou(userData: null,));
                },
              ).box.width(context.screenWidth - 55).make(),
              // Spacer
              20.heightBox,
            ],
          ).box.padding(EdgeInsets.all(20)).make(),
        ),
      ),
    );
  }
}

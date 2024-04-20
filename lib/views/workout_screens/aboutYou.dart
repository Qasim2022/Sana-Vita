
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled/common_widgets/buttonWidget.dart';
import 'package:untitled/common_widgets/custom_textformfield.dart';
import 'package:untitled/consts/consts.dart';

import '../../common_widgets/radioButton.dart';
import '../../model/user_model.dart';
import '../controllers/radioController.dart';
import '../workout_screens/workoutScreen.dart';




class AboutYou extends StatefulWidget {
  final AddUserModel userData;

  const AboutYou({Key? key, required this.userData, }) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Step 1: Create GlobalKey<FormState>
String?selectedGender;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightGrey,
        body: Form( // Step 2: Wrap form widgets with Form widget
          key: _formKey, // Step 2: Assign the created GlobalKey<FormState>
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: (context.screenHeight * 0.05)),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tell us about you',
                  style: TextStyle(
                    fontFamily: semibold,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                type: TextFieldType.number,
                controller: ageController,
                title: 'Age',
                hint: 'Enter your age',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }

                  // Check if the value is a valid integer
                  try {
                    int age = int.parse(value);
                    if (age > 100) {
                      return 'Age cannot be greater than 100';
                    }
                  } catch (e) {
                    return 'Only digits are allowed for age';
                  }

                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: TextStyle(
                    color: fontBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: semibold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Gender Dropdown

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:    RadioListTile(
                      title:Text(male, style: TextStyle(
                        color: fontBlack,
                        fontWeight: FontWeight.w400,
                        fontFamily: semibold,
                        fontSize: 16,
                      )),
                      value: male,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child:   RadioListTile(
                      title:Text(female, style: TextStyle(
                        color: fontBlack,
                        fontWeight: FontWeight.w400,
                        fontFamily: semibold,
                        fontSize: 16,
                      )),
                      value:female,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),

                ],
              ),




              // CustomTextField for height
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      type: TextFieldType.number,
                      controller: heightController,
                      title: 'Height (cm)',
                      hint: 'Enter your height',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter height';
                        }
                        try {
                          int height = int.parse(value);

                          if (height > 244) {
                            return 'Not more than 244';
                          }
                          else if (height < 80) {
                            return 'Not less than 80';
                          }
                        } catch (e) {
                          return 'Only digits allowed';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextField(
                      type: TextFieldType.number,
                      controller: weightController,
                      title: 'Weight (kg)',
                      hint: 'Enter your weight',
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
                    ),
                  ),
                ],
              ),
             // SizedBox(height: 10),
              const Spacer(),
              ButtonWidget(
                title: 'Next',
                color: skyColor,
                onPress: () {
                  // Step 3: Validate the form before navigating to the next screen
                  if (_formKey.currentState!.validate()) {

                    widget.userData.age = int.parse(ageController.text);
                    widget.userData.height = double.parse(heightController.text);
                    widget.userData.weight = double.parse(weightController.text);
                    Get.to(() => WorkoutScreen(userData: widget.userData));
                  }
                },
              ).box.width(context.screenWidth - 55).make(),
              const SizedBox(height: 15),
            ],
          ).box.padding(const EdgeInsets.all(20)).make(),
        ),
      ),
    );
  }
}

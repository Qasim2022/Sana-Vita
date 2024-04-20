import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/consts.dart';

import '../../common_widgets/radioButton.dart';
import '../../consts/colors.dart';
import '../controllers/radioController.dart';

// Screen for selecting languages
class LanguagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGrey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Spacer
              (context.screenHeight * 0.05).heightBox,
              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: "Languages".text.size(24).fontFamily(bold).make(),
                ),
              ),
              // Spacer
              10.heightBox,
              // List of radio buttons for selecting languages
              SingleChildScrollView(
                child: GetBuilder(
                  init: RadioController(),
                  builder: (RadioController radioController) {
                    return Column(
                      children: [
                        // English radio button
                        RadioButtonWidget(
                          icon: icL1,
                          title: "English",
                          value: "English",
                          groupValue: radioController.selectedLanguage.value,
                          onChanged: (val) {
                            radioController.selectOption(radioController.selectedLanguage, val);
                          },
                        ),
                        // Spanish radio button
                        RadioButtonWidget(
                          icon: icL2,
                          title: "Spanish",
                          value: "Spanish",
                          onChanged: (val) {
                            radioController.selectOption(radioController.selectedLanguage, val);
                          },
                        ),
                        // French radio button
                        RadioButtonWidget(
                          icon: icL3,
                          title: "French",
                          value: "French",
                          onChanged: (val) {
                            radioController.selectOption(radioController.selectedLanguage, val);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

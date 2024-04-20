import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:untitled/common_widgets/radioButton.dart';
import 'package:untitled/consts/consts.dart';


// Widget representing a radio button with a title and an icon, using GetX for state management
// Parameters:
// - value: The value associated with the radio button
// - title: Title text to be displayed alongside the radio button
// - icon: Icon to be displayed alongside the title
Widget RadioButtonWidgetF({String? value, String? title, String? icon}) {
  return Obx(
    // Obx widget ensures that the UI is updated when the selected value changes
        () => RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(icon!),
          ),
          title!.text.make(),
        ],
      ),
      value: value,
      // The group value is obtained from the RadioController using GetX
      groupValue: radioController.selectedGoal.value,
      // When the radio button is changed, update the selected value in the RadioController
      onChanged: (value) {
        radioController.selectedGoal(value!);
      },
    ),
  );
}

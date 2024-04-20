import 'package:flutter/material.dart';
import 'package:untitled/consts/consts.dart';

import '../consts/colors.dart';

// A custom widget representing a button
// Parameters:
// - title: Title text to be displayed on the button
// - onPress: Callback function for button press
// - color: Background color of the button
// - textColor: Text color of the button
// - disabled: Flag to indicate if the button is disabled
Widget ButtonWidget({String? title, Function()? onPress, Color? color, Color? textColor, bool? disabled}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: disabled == true ? Colors.grey : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor ?? whiteColor).fontFamily(semibold).size(16).make(), // Creating text from 'title' using supercharged extension
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/consts/consts.dart';
import '../consts/colors.dart';

// Enum for different text field types
enum TextFieldType {
  text,
  number,
  email,
  password,
}

// A custom widget representing a text field with a title
// Parameters:
// - title: Title text displayed above the text field
// - hint: Hint text displayed inside the text field
// - controller: Text editing controller for the text field
// - validator: Validation function for the text field
// - type: Type of the text field input
Widget CustomTextField({
  String? title,
  String? hint,
  bool hide=false,
  Widget?suffixIcon,
  TextEditingController? controller,
  String? Function(String?)? validator,
  TextFieldType type = TextFieldType.text, // Default text field type is text
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title text
      title!.text.color(fontBlack).fontWeight(FontWeight.w400).fontFamily(
          semibold).size(16).make(),
      5.heightBox, // Spacer
      // Text form field with validation and input type
      TextFormField(
        controller: controller,
        obscureText: hide,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          // Borders
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade50,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade50,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade50,
            ),
          ),
        ),
        validator: validator,
        keyboardType: _getKeyboardType(
            type), // Setting the keyboard type based on the text field type
      ),
      10.heightBox, // Spacer
    ],
  );
}

// Function to get the keyboard type based on the text field type
TextInputType _getKeyboardType(TextFieldType type) {
  switch (type) {
    case TextFieldType.number:
      return TextInputType.number;
    case TextFieldType.email:
      return TextInputType.emailAddress;
    case TextFieldType.password:
      return TextInputType.visiblePassword;
    case TextFieldType.text:
    default:
      return TextInputType.text;
  }
}

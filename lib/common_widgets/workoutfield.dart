import 'package:flutter/material.dart';
import 'package:untitled/consts/consts.dart';
import '../consts/colors.dart';

// Widget representing a workout field with title and subtitle
// Parameters:
// - width: Width of the container
// - title: Title text displayed in the center of the container
// - subTitle: Subtitle text displayed below the title
// - selected: Flag to indicate if the workout field is selected
// - onTap: Callback function to be called when the container is tapped
Widget WorkoutField({double? width, String? title, String? subTitle, bool? selected, VoidCallback? onTap}) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected == true ? skyColor : Colors.transparent,
          border: Border.all(color: selected == true ? skyColor : Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title text
            title!.text.color(fontBlack).size(20).fontWeight(FontWeight.w400).fontFamily(regular).make(),
            // Subtitle text
            subTitle!.text.color(Colors.grey).size(18).fontWeight(FontWeight.w400).fontFamily(regular).make(),
          ],
        )
        // Styling the container
            .box
            .white
            .width(width!)
            .padding(EdgeInsets.all(19))
            .rounded
            .make(),
      ),
    ),
  );
}

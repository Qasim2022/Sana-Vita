import 'package:flutter/cupertino.dart';
import 'package:untitled/consts/consts.dart';


// A custom widget representing a box with title and icon
// Parameters:
// - width: Width of the box
// - title: Title text to be displayed
// - icon: Path to the icon asset to be displayed
Widget BoxWidget({width, String? title,Widget ? child, String? icon,VoidCallback?onTap,VoidCallback?onTapText,Widget?requireWidget}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title text widget
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
                onTap:onTapText ,
                child: title!.text.make()), // Creating text from 'title' using supercharged extension
          ),
          // Icon widget
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
                onTap: onTap,
                child: Image.asset(icon as String, width: 20,)),
          ),
        ],
      )
      // Applying styling to the box
          .box
          .white
          .width(width)
          .roundedSM
          .shadowSm
          .height(55)
          .make(),
      5.heightBox,
      Padding(padding:const EdgeInsets.symmetric(horizontal: 10,),child: requireWidget,)

    ],
  );
}

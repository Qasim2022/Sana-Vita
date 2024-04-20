import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/consts.dart';

import '../../common_widgets/RadioFriend.dart';
import '../../common_widgets/radioButton.dart';
import '../../consts/images.dart';

// Screen for inviting a friend
class InviteFriend extends StatelessWidget {
  const InviteFriend({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container decoration
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      // Container height
      height: Get.height * .8,
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            // Row for header with cancel and invite buttons
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel button
                  "Cancel".text.make(),
                  // Title
                  "Invite a Friend".text.fontFamily(regular).size(20).make(),
                  // Invite button
                  TextButton(
                    onPressed: () {
                      // Button onPressed logic
                    },
                    child: Text(
                      'Invite',
                      style: TextStyle(
                        color: Colors.grey, // Text color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search field
            SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Container(
                  height: 53,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: search,
                      hintStyle: TextStyle(color: textfieldGrey),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // List of radio buttons for friends
            Column(
              children: [
                RadioButtonWidgetF(icon: icS1, title: cameron, value: cameron),
                RadioButtonWidgetF(icon: icS2, title: wade, value: wade),
                RadioButtonWidgetF(icon: icS3, title: esther, value: esther),
                RadioButtonWidgetF(icon: icS4, title: annette, value: annette),
                RadioButtonWidgetF(icon: icS5, title: darlene, value: darlene),
                RadioButtonWidgetF(icon: icS6, title: janeCooper, value: janeCooper),
                RadioButtonWidgetF(icon: icS7, title: floyd, value: floyd),
                RadioButtonWidgetF(icon: icS8, title: courtney, value: courtney),
                RadioButtonWidgetF(icon: icS9, title: ronald, value: ronald),
                RadioButtonWidgetF(icon: icS10, title: ralph, value: ralph),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

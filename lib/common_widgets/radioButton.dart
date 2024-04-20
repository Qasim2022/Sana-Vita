import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/consts/consts.dart';
import '../views/controllers/radioController.dart';

final RadioController radioController = Get.put(RadioController());
Widget RadioButtonWidget({ String? value, String? title,String? icon,String?groupValue,
  onChanged}){
  return RadioListTile(
    title: Row(
      children: [
          if(icon!=null)
            Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
          child: Image.asset(icon),
        ),
        title!.text.make(),
      ],
    ),

    // title: title!.text.make(),
  value: value,
  groupValue: groupValue,
  onChanged: onChanged,
  )
  .box.white.margin(const EdgeInsets.symmetric(horizontal: 20,vertical: 5)).roundedSM.border(color: lightGrey).shadowXs.make();
}
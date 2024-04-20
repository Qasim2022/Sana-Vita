
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:untitled/consts/consts.dart';

import '../../../common_widgets/buttonWidget.dart';
import '../../../consts/colors.dart';
import '../../../consts/strings.dart';
class DialogForCalender extends StatefulWidget {


  const DialogForCalender({Key? key,}) : super(key: key);

  @override
  State<DialogForCalender> createState() => _DialogForCalenderState();
}

class _DialogForCalenderState extends State<DialogForCalender> {



  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.grey.shade500,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
           SfCalendar(
           view: CalendarView.month,
         ),],),),
      ),
    );
  }
}
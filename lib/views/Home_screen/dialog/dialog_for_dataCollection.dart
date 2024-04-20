
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untitled/consts/consts.dart';

import '../../../common_widgets/buttonWidget.dart';
import '../../../consts/colors.dart';
import '../../../consts/strings.dart';
class DialogForData extends StatefulWidget {
  final Function(int) collectData;

  const DialogForData({Key? key, required this.collectData}) : super(key: key);

  @override
  State<DialogForData> createState() => _DialogForDataState();
}

class _DialogForDataState extends State<DialogForData> {
  late TextEditingController _textFieldController; // Declare controller

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController(); // Initialize controller
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.grey.shade500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text("Enter Calories", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.60), fontSize: 16)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  hintText: 'Enter Calories ',
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
              ),

              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                title: save,
                color: skyColor,
                onPress: () {
                  String inputValue = _textFieldController.text;
                  int intValue = int.tryParse(inputValue) ?? 0; // Convert text to integer, defaulting to 0 if conversion fails
                  widget.collectData(intValue);// Call callback function
                  Navigator.of(context).pop();
                },
              ).box.width(context.screenWidth - 55).make(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
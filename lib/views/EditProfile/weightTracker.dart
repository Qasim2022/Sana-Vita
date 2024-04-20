import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common_widgets/radioButton.dart';
import 'package:untitled/consts/consts.dart';
import 'package:untitled/views/workout_screens/aboutYou.dart';
import '../../consts/colors.dart';
import '../../model/user_model.dart';
import 'addWeightScreen.dart';

class WeightTracker extends StatefulWidget {
   AddUserModel userData; // Add this line
   WeightTracker({Key? key,required this.userData});
  @override
  State<WeightTracker> createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  double margin = 32;
  List<int> items = [20, 35, 20, 55, 70, 55, 65];
  List items1 = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  int selected = 0;
  String? valueChoose;
  List<String> listItem = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

TextEditingController enterWeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //int ?leftData;

    Size size = MediaQuery.of(context).size;
    double width =
        ((size.width - margin) - ((items.length + 1) * 30)) / items.length;
    double? leftData;
    if (enterWeight != null) {
      double bodyWeight = widget.userData.weight ?? 0.0;


      // Use null-aware operator to assert that enterWeight is not null
      int enterWeightInt = int.tryParse( enterWeight.text)?? 0;

      leftData = bodyWeight - enterWeightInt;
    }
   // int enterWeightFinal = int.tryParse(enterWeight.text) ?? 0;





    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("left data =${leftData}");
          print("enter data =${enterWeight.text}");
          print("body data =${widget.userData.weight}");
          showDialog(

            context: context,
            builder: (BuildContext context) {
              return Material(
                color: Colors.white,
                child: Dialog(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Spacer
                        (context.screenHeight * 0.05).heightBox,
                        // Cancel button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: cancel.text.size(20).fontFamily(semibold).make(),
                            ),
                          ),
                        ),
                        // Container for weight entry
                        Container(
                          width: double.infinity,
                          height: Get.height * 0.35,
                          padding: EdgeInsets.only(left: 18),
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: Get.height * 0.4,
                                  width: Get.width * 0.9,
                                  child: Center(
                                    child: Image.asset(
                                      icCircle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: Get.height * 0.0998,
                                  left: Get.width * 0.20,
                                  child: Text(
                                    "Enter Weight",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  top: Get.height * 0.12,
                                  child: Center(
                                    child: Container(
                                      width: 35,
                                      child: TextFormField(
                                        controller: enterWeight,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '63.5',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: Get.height * 0.2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Button for KG
                                      Container(
                                        width: Get.width * 0.17,
                                        height: Get.height * 0.025,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            String inputValue = enterWeight.text;
                                            // int intValue = int.tryParse(inputValue) ?? 0; // Convert text to integer, defaulting to 0 if conversion fails
                                            // widget.enterWeight(intValue);
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightBlue,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: Text("KG"),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      // Button for LB
                                      Container(
                                        width: Get.width * 0.16,
                                        height: Get.height * 0.025,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Implement functionality for the second button
                                          },
                                          child: Text("LB"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

          // Get.to(() => EnterWeight(
          //      // enterWeight: enterWeightValue,
          //     ));
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          color: lightGrey,
          child: ListView(
            children: [
              75.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Weight Tracker".text.size(23).fontFamily(semibold).make(),
                    Container(
                      decoration: BoxDecoration(
                        color: skyColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: DropdownButton<String>(
                        hint: const Text("Week"),
                        value: valueChoose,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = newValue!;
                          });
                        },
                        items: listItem.map((valueItem) {
                          return DropdownMenuItem<String>(
                            value: valueItem,
                            child: Text(
                              valueItem,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              40.heightBox,
              Container(
                width: Get.width,
                height: 240,
                padding: const EdgeInsets.only(left: 18, top: 20),
                margin: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (int i = 0; i < items.length; i++)
                            Container(
                              width: width,
                              height: items.elementAt(i) * 250 / 110,
                              margin: const EdgeInsets.only(right: 31.5),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color:
                                    (selected == i ? Colors.grey : Colors.blue),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        for (int i = 0; i < items1.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Text(
                              items1[i],
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: darkFontGrey,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 170,
                padding: const EdgeInsets.only(left: 18),
                margin: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: "your progress"
                            .text
                            .size(17)
                            .fontFamily(regular)
                            .make(),
                      ),
                      30.heightBox,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Current".text.color(Colors.grey).make(),
                              "Left".text.color(Colors.grey).make(),
                              "Target".text.color(Colors.grey).make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.userData.weight==""?   Text('0 Kg'):   Text('${widget.userData.weight} Kg'),
                              Text('$leftData Kg'),
                             Text(enterWeight.text),
                            ],
                          ),
                        ],
                      ),
                      10.heightBox,
                      const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: LinearProgressIndicator(
                          value: 0.4,
                          minHeight: 10,
                          backgroundColor: Color(0xffE2E2E2),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ],
                  )
                      .box
                      .margin(const EdgeInsets.only(left: 20, right: 40))
                      .make(),
                ),
              ),
              40.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

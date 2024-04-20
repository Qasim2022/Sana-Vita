// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled/consts/consts.dart';
// import 'package:untitled/views/EditProfile/weightTracker.dart';
//
//
// // Screen for entering weight
// class EnterWeight extends StatefulWidget {
//
//   const EnterWeight({Key? key, required this.enterWeight});
//
//   @override
//   State<EnterWeight> createState() => _EnterWeightState();
// }
//
// class _EnterWeightState extends State<EnterWeight> {
//   late TextEditingController _enterWeight; // Declare controller
//
//   @override
//   void initState() {
//     super.initState();
//     _enterWeight = TextEditingController(); // Initialize controller
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Spacer
//             (context.screenHeight * 0.05).heightBox,
//             // Cancel button
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//                 //Get.to(() => WeightTracker());
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: cancel.text.size(20).fontFamily(semibold).make(),
//                 ),
//               ),
//             ),
//             // Container for weight entry
//             Container(
//               width: double.infinity,
//               height: Get.height * 0.35,
//               padding: EdgeInsets.only(left: 18),
//               margin: EdgeInsets.symmetric(horizontal: 13),
//               decoration: BoxDecoration(
//                 color: Colors.lightBlueAccent.withOpacity(.05),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Container(
//                       height: Get.height * 0.4,
//                       width: Get.width * 0.9,
//                       child: Center(
//                         child: Image.asset(
//                           icCircle,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: Get.height * 0.0998,
//                       left: Get.width * 0.32,
//                       child: Text(
//                         "Enter Weight",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Positioned(
//                       top: Get.height * 0.12,
//                       child: Center(
//                         child: Container(
//                           width: 35,
//                           child: TextFormField(
//                             controller: _enterWeight,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               hintText: '63.5',
//
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: Get.height * 0.2,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Button for KG
//                           Container(
//                             width: Get.width * 0.17,
//                             height: Get.height * 0.025,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Implement functionality for the first button
//                                 String inputValue = _enterWeight.text;
//                                 int intValue = int.tryParse(inputValue) ?? 0; // Convert text to integer, defaulting to 0 if conversion fails
//                                 widget.enterWeight(intValue);
//                                 Navigator.pop(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.lightBlue,
//                                 foregroundColor: Colors.white,
//                               ),
//                               child: Text("KG"),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           // Button for LB
//                           Container(
//                             width: Get.width * 0.16,
//                             height: Get.height * 0.025,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Implement functionality for the second button
//                               },
//                               child: Text("LB"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

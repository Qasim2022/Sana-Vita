import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled/views/Home_screen/train.dart';
import 'package:untitled/views/splashScreen/splash_screen.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: sanaVital, // Set app title
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Set scaffold background color
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, // Set app bar background color
        ),),
      home: const SplashScreen(), // Set the initial route to SplashScreen
    );
  }
}

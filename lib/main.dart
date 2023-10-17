import 'package:flutter/material.dart';
import 'package:wather_app/screens/Screen0.dart';
import 'package:wather_app/screens/splashscreen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: "/",
      routes: {
        '/':(context) => const splashscreen(),
          '':(context) => const Screen0(),
       
      },
    );
  }
}

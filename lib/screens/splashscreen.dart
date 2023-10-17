// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wather_app/screens/screen0.dart';



class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen0(),));
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Image(
                image: AssetImage("images/weathersplash.png"),
                fit: BoxFit.fill,
              ))
        ],
      ),
    );
  }
}
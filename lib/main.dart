// ignore_for_file: prefer_const_constructors

import 'package:cov19_tracker/maindata.dart';
import 'package:cov19_tracker/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Compatil', primaryColor: redOrange),
      home: SplashPage(),
    );
  }
}

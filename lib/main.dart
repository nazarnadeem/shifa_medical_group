import 'package:flutter/material.dart';
import 'package:shifa_medical_group/pages/login.dart';
import 'package:shifa_medical_group/pages/signup.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp(),);
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Login(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phoneauth/homepage.dart';
import 'package:phoneauth/phonenumber.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(cardColor: Color(0xff2E3B62)),
      home: homepage(),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:appnotesusingphp/addnote.dart';
import 'package:appnotesusingphp/home.dart';
import 'package:appnotesusingphp/login.dart';
import 'package:appnotesusingphp/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedprefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedprefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: sharedprefs!.getString('id') == null ? "login" : "home",
      routes: {
        "login": (context) => LogIn(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "addnote": (context) => AddNote(),
      },
    );
  }
}
//
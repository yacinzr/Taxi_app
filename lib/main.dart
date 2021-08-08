import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/screens/Loginpage.dart';
import 'package:taxiapp/screens/home.dart';
import 'package:taxiapp/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/signup',
    routes: {
      '/home': (context) => Home(),
      '/login': (context) => Loginpage(),
      '/signup': (context) => Signup(),
    },
  ));
}

DatabaseReference usersref =
    FirebaseDatabase.instance.reference().child("user");

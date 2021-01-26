import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portal_task/Admin/specificattendance.dart';
import 'package:portal_task/Welcomepage.dart';
import 'package:portal_task/startingpage.dart';
import 'Student/signup.dart';
import 'Student/login.dart';
import 'Admin/loginAdmin.dart';
import 'Student/student.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Student/Attendance.dart';
import 'Student/Application.dart';
import 'Admin/Admin.dart';
import 'Admin/SpecificPersonAttendance.dart';
import 'Admin/SpecificPersonAttendance.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: startingpage.id,
      routes: {
        startingpage.id: (context) => startingpage(),
        Welcomepage.id: (context) => Welcomepage(),
        signup.id: (context) => signup(),
        login.id: (context) => login(),
        loginAdmin.id: (context) => loginAdmin(),
        student.id: (context) => student(),
        Attendance.id: (context) => Attendance(),
        Application.id: (context) => Application(),
        Admin.id: (context) => Admin(),
        SpecificPersonAttendance.id: (context) => SpecificPersonAttendance(),
        specificattendance.id: (context) => specificattendance(),
      },
    );
  }
}

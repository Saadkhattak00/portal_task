import 'package:flutter/material.dart';
import 'package:portal_task/Admin/loginAdmin.dart';
import 'package:portal_task/Student/login.dart';

class Welcomepage extends StatefulWidget {
  static String id = 'Welcomepage';
  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/welcome.jpg'),
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school_outlined,
                  color: Colors.black,
                  size: 120,
                ),
                Text(
                  'Attendance Management System',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blueGrey,
                    minWidth: 200,
                    height: 45,
                    child: Text(
                      'Student',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, login.id);
                    }),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blueGrey,
                    minWidth: 200,
                    height: 45,
                    child: Text(
                      'Admin',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, loginAdmin.id);
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

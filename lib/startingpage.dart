import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:portal_task/Welcomepage.dart';

class startingpage extends StatefulWidget {
  static String id = 'startingpage';
  @override
  _startingpageState createState() => _startingpageState();
}

class _startingpageState extends State<startingpage>
    with TickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    Timer(Duration(milliseconds: 2000), () {
      Navigator.pushNamed(context, Welcomepage.id);
    });
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      upperBound: 1,
      lowerBound: -1,
      value: 0.0,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: controller,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                color: Colors.blueGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      color: Colors.black,
                      size: 120,
                    ),
                    Text(
                      'Attendance Management System',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
              builder: (BuildContext context, Widget child) {
                return ClipPath(
                  clipper: DrawClip(controller.value),
                  child: child,
                );
              },
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      '   WELCOME TO\n        BUILD A \n BRIGHT FUTURE',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double x =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double y = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(x, y, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

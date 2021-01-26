import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Attendance extends StatefulWidget {
  static String id = 'Attendance';

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              centerTitle: true,
              title: Text(
                'Attendance Sheet',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: firebase.collection(auth.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final detailid = snapshot.data.docs;
                  List<Widget> items = [];
                  int day, month, year;
                  bool present, absent;
                  var data;
                  for (var detail in detailid) {
                    if (detail.id == 'Profile' || detail.id == 'Leave') {
                    } else {
                      data = detail.data();
                      day = data['Day'];
                      month = data['Month'];
                      year = data['Year'];
                      present = data['Present'];
                      absent = data['Absent'];
                      final datadetail = Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(0, 5))
                                  ],
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$day/$month/$year",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  SizedBox(width: 80),
                                  Container(
                                      child: present
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          : Icon(Icons.clear,
                                              color: Colors.red)),
                                  SizedBox(
                                    width: 140,
                                  ),
                                  Container(
                                      child: absent
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          : Icon(Icons.clear,
                                              color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );

                      items.add(datadetail);
                    }
                  }
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 2, right: 2, bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(8)),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text('Date',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                SizedBox(
                                  width: 95,
                                ),
                                Container(
                                    child: Text('Present',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                SizedBox(
                                  width: 95,
                                ),
                                Container(
                                  child: Text(
                                    'Absent',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: items,
                        )
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portal_task/Admin/sheet.dart';
import 'package:portal_task/Admin/specificattendance.dart';

class SpecificPersonAttendance extends StatefulWidget {
  static String id = 'SpecificPersonAttendance';

  String userid;
  String Name;

  SpecificPersonAttendance({this.userid, this.Name});
  @override
  _SpecificPersonAttendanceState createState() =>
      _SpecificPersonAttendanceState();
}

class _SpecificPersonAttendanceState extends State<SpecificPersonAttendance> {
  final firestore = FirebaseFirestore.instance;
  int Presentday = 0;
  int result;
  int Days = 0;
  String Grade;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Sheet(
              uid: widget.userid,
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.Name),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              icon: Icon(
                Icons.folder_special_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, specificattendance.id);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection(widget.userid).snapshots(),
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
                  String date = '$day$month$year';
                  Days++;
                  if (present == true) {
                    Presentday++;
                  }
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
                              PopupMenuButton(
                                onSelected: (i) async {
                                  await firestore
                                      .collection(widget.userid)
                                      .doc(date)
                                      .delete();
                                  print('nothing delete');
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      height: 2,
                                      child: Text('Delete')),
                                ],
                                child: Text("$day/$month/$year",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                              SizedBox(width: 80),
                              PopupMenuButton(
                                onSelected: (i) async {
                                  if (i == 1) {
                                    await firestore
                                        .collection(widget.userid)
                                        .doc(date)
                                        .update({
                                      'Absent': false,
                                      'Present': true,
                                    });
                                  } else {
                                    await firestore
                                        .collection(widget.userid)
                                        .doc(date)
                                        .update({
                                      'Absent': true,
                                      'Present': false,
                                    });
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ))
                                ],
                                child: Container(
                                    child: present
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          )
                                        : Icon(Icons.clear, color: Colors.red)),
                              ),
                              SizedBox(
                                width: 140,
                              ),
                              PopupMenuButton(
                                onSelected: (i) async {
                                  if (i == 1) {
                                    await firestore
                                        .collection(widget.userid)
                                        .doc(date)
                                        .update({
                                      'Absent': true,
                                      'Present': false,
                                    });
                                  } else {
                                    await firestore
                                        .collection(widget.userid)
                                        .doc(date)
                                        .update({
                                      'Absent': false,
                                      'Present': true,
                                    });
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ))
                                ],
                                child: Container(
                                    child: absent
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          )
                                        : Icon(Icons.clear, color: Colors.red)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                  items.add(datadetail);
                  double percent = Presentday / Days;
                  percent = percent * 100;
                  result = percent.ceil();
                  print(result);
                  if (result >= 80 && result <= 100) {
                    Grade = 'A';
                  } else if (result >= 70 && result < 80) {
                    Grade = 'B';
                  } else if (result >= 60 && result < 70) {
                    Grade = 'C';
                  } else {
                    Grade = 'D';
                  }
                }
              }
              final qq = Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  'Attendance Grade is $Grade',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              );
              items.add(qq);
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
                                        color: Colors.black, fontSize: 20))),
                            SizedBox(
                              width: 95,
                            ),
                            Container(
                                child: Text('Present',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20))),
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
        ),
      ),
    ));
  }
}

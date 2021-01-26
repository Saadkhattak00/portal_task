import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal_task/Student/Application.dart';
import 'package:portal_task/Student/Attendance.dart';
import 'package:portal_task/Student/login.dart';
import 'package:image_picker/image_picker.dart';

class student extends StatefulWidget {
  static String id = 'student';

  @override
  _studentState createState() => _studentState();
}

class _studentState extends State<student> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  bool _disableButton = false;
  int SelectedState;
  bool present = false;
  bool absent = false;
  int day, month, year;
  String name;
  String email;
  File _image;
  get() {
    day = int.parse(formatDate(DateTime.now(), [dd]));
    month = int.parse(formatDate(DateTime.now(), [mm]));
    year = int.parse(formatDate(DateTime.now(), [yyyy]));
  }

  lastdate() async {
    //rd mean Refrance of doc
    final rd = await firebase.collection(auth.uid).get();
    for (int i = 0; i < rd.size; i++) {
      String DocName = await rd.docs[i].id;
      if (DocName == "$day$month$year") {
        setState(() {
          _disableButton = true;
        });
      }
    }
  }

  fetching() async {
    final data = await firebase.collection(auth.uid).doc('Profile').get();
    name = data.get('Name');
    email = data.get('Email');
  }

  Future getimage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (file != null) {
        _image = File(file.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SelectedState = 0;
    get();
    lastdate();
    fetching();
  }

  setSelectedState(int val) {
    setState(() {
      SelectedState = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: FutureBuilder(
            future: firebase.collection(auth.uid).doc().get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Drawer(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DrawerHeader(
                            decoration: BoxDecoration(color: Colors.blueGrey),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: GestureDetector(
                                    onTap: () {
                                      getimage();
                                    },
                                    child: Container(
                                        width: 130,
                                        height: 130,
                                        color: Colors.grey,
                                        child: _image == null
                                            ? Icon(
                                                Icons.person,
                                                color: Colors.black45,
                                                size: 80,
                                              )
                                            : Image.file(
                                                _image,
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 1,
                          endIndent: 1,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            email,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 1,
                          endIndent: 1,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Divider(
                                  thickness: 2,
                                  indent: 1,
                                  endIndent: 1,
                                ),
                                Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(context, login.id);
                                    },
                                    title: Text(
                                      'Logout',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade600,
          // leading: Container(
          //   decoration: BoxDecoration(
          //       color: Colors.blueGrey.shade700,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.zero,
          //           topRight: Radius.circular(5),
          //           bottomRight: Radius.circular(5),
          //           bottomLeft: Radius.zero)),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.perm_identity,
          //       color: Colors.black,
          //       size: 30,
          //     ),
          //     onPressed: () {},
          //   ),
          // ),

          title: Text(
            'Student Portal',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          // actions: [
          //   Container(
          //     decoration: BoxDecoration(
          //         color: Colors.blueGrey.shade700,
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.zero,
          //             topLeft: Radius.circular(5),
          //             bottomLeft: Radius.circular(5),
          //             bottomRight: Radius.zero)),
          //     child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.more_vert,
          //         size: 30,
          //         color: Colors.black,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Date: ",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  "$day/$month/$year",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )),
            SizedBox(
              height: 60,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Attendance Selection',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Be Careful Once You Pressed on Submit \nThen You Can\'t Change your Attendance.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Present',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    Radio(
                        activeColor: Colors.blue,
                        value: 1,
                        groupValue: SelectedState,
                        onChanged: (val) {
                          setSelectedState(val);
                          setState(() {
                            present = true;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  width: 80,
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Absent',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    Radio(
                        activeColor: Colors.blue,
                        value: 2,
                        groupValue: SelectedState,
                        onChanged: (val) {
                          setSelectedState(val);
                          setState(() {
                            absent = true;
                          });
                        }),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
                height: 40,
                minWidth: 150,
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onPressed: _disableButton
                    ? null
                    : () async {
                        final CurrentUser = FirebaseAuth.instance.currentUser;
                        setState(() {
                          firebase
                              .collection(CurrentUser.uid)
                              .doc('$day$month$year')
                              .set({
                            'Present': present,
                            'Absent': absent,
                            'Day': day,
                            'Month': month,
                            'Year': year,
                          });
                          _disableButton = true;
                        });
                      }),
            SizedBox(
              height: 40,
            ),
            Divider(
              thickness: 1,
              endIndent: 70,
              indent: 70,
              color: Colors.black,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    height: 40,
                    minWidth: 150,
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'VIEW ATTENDANCE',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Attendance.id);
                    }),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                    height: 40,
                    minWidth: 150,
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'APPLICATION',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Application(
                          Name: name,
                        );
                      }));
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

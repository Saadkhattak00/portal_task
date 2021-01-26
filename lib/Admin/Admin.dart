import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal_task/Admin/SpecificPersonAttendance.dart';

class Admin extends StatefulWidget {
  static String id = 'Admin';
  final fatchlist;
  Admin({this.fatchlist});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final firestore = FirebaseFirestore.instance;
  List<Widget> llist = [];
  data() async {
    for (String x in widget.fatchlist) {
      print(x);
      String Name;
      String Email;
      getinfo() async {
        return await firestore.collection(x).get().then((value) {
          for (var a in value.docs) {
            if (a.id == 'Profile') {
              getsnapshot() async {
                return await firestore.collection(x).doc(a.id).get();
              }

              getsnapshot().then((value) {
                setState(() {
                  Name = value.get('Name');
                  Email = value.get('Email');
                });
                final view = Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SpecificPersonAttendance(
                              userid: x,
                              Name: Name,
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 6, right: 6, left: 6, bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8,
                                      spreadRadius: 3,
                                      offset: Offset(0, 5))
                                ],
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 8,
                                              spreadRadius: 5,
                                              offset: Offset(0, 0))
                                        ],
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.zero,
                                            bottomLeft: Radius.circular(7),
                                            bottomRight: Radius.zero)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black54,
                                      size: 80,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 138,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 23),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            Email,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                llist.add(view);
              });
            }
          }
        });
      }

      getinfo();
    }
  }

  @override
  void initState() {
    data();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text('Admin'),
        actions: [
          IconButton(
              icon: Icon(Icons.mark_chat_unread),
              color: Colors.white,
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 15, right: 6, left: 6, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                  "Student's Record",
                  style: TextStyle(fontSize: 25),
                )),
              ),
            ),
            Column(
              children: llist,
            )
          ],
        ),
      ),
    ));
  }
}

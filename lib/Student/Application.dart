import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

class Application extends StatefulWidget {
  static String id = 'Application';
  final String Name;
  Application({this.Name});
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  int day, month, year;
  String Application;
  String Subject;
  String from = 'From';
  String to = 'To';

  final subjetfield = TextEditingController();
  final applicationfield = TextEditingController();

  void getclear() {
    subjetfield.clear();
    applicationfield.clear();
  }

  get() {
    day = int.parse(formatDate(DateTime.now(), [dd]));
    month = int.parse(formatDate(DateTime.now(), [mm]));
    year = int.parse(formatDate(DateTime.now(), [yyyy]));
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            'Application',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Application For Leave',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2022))
                            .then((value) {
                          formatDate(value, [dd, '/', mm, '/', yyyy]);
                          setState(() {
                            from = formatDate(value, [dd, '/', mm, '/', yyyy])
                                .toString();
                          });
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.blueGrey,
                      child: Text(
                        from == null ? "From" : from,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    VerticalDivider(
                      width: 80,
                    ),
                    MaterialButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2022))
                            .then((value) {
                          formatDate(value, [dd, '/', mm, '/', yyyy]);
                          setState(() {
                            to = formatDate(value, [dd, '/', mm, '/', yyyy])
                                .toString();
                          });
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.blueGrey,
                      child: Text(
                        to == null ? "To" : to,
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 5, bottom: 0),
                    child: Container(
                      height: 65,
                      child: TextField(
                        controller: subjetfield,
                        onSubmitted: (String value) {
                          Subject = value;
                        },
                        onChanged: (String value) {
                          Subject = value;
                        },
                        maxLines: 30,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Subject',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 5, bottom: 10),
                    child: Container(
                      height: 250,
                      child: TextField(
                        controller: applicationfield,
                        onSubmitted: (String value) {
                          Application = value;
                        },
                        maxLines: 100,
                        minLines: 12,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Type your Application here',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Center(
                      child: MaterialButton(
                        height: 40,
                        minWidth: 160,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async {
                          final CurrentUser =
                              await FirebaseAuth.instance.currentUser;
                          if (from == 'From' || to == 'To') {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Text(
                                          'Select Date!',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ));
                          } else {
                            setState(() {
                              firebase
                                  .collection(CurrentUser.uid)
                                  .doc('Leave')
                                  .set({
                                'Subject': Subject,
                                'application': Application,
                                'name': widget.Name,
                                'DateFrom': from,
                                'DateTo': to,
                              });
                            });
                            getclear();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Text(
                                          'Application Successfully Submitted',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ));
                          }
                        },
                        color: Colors.blueGrey,
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}

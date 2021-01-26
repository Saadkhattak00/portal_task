import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sheet extends StatefulWidget {
  String uid;
  Sheet({this.uid});
  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  final firestore = FirebaseFirestore.instance;
  int SelectedState;
  bool present = false;
  bool absent = false;
  String date;
  int day;
  int month;
  int year;
  int Days;
  int Months;
  int Years;

  get() {
    day = int.parse(formatDate(DateTime.now(), [dd]));
    month = int.parse(formatDate(DateTime.now(), [mm]));
    year = int.parse(formatDate(DateTime.now(), [yyyy]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedState = 0;
  }

  setSelectedState(int val) {
    setState(() {
      SelectedState = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Container(
                child: Text(
                  'Add Attendance',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Text(
                          'Present',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Text(
                          'Absent',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2022))
                              .then((value) {
                            formatDate(value, [dd, '/', mm, '/', yyyy]);
                            setState(() {
                              date = formatDate(value, [dd, '/', mm, '/', yyyy])
                                  .toString();
                              Days = int.parse(formatDate(value, [dd]));
                              Months = int.parse(formatDate(value, [mm]));
                              Years = int.parse(formatDate(value, [yyyy]));
                            });
                          });
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            date == null ? 'Select Date' : date,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Radio(
                              activeColor: Colors.blue,
                              value: 1,
                              groupValue: SelectedState,
                              onChanged: (val) {
                                setSelectedState(val);
                                setState(() {
                                  present = true;
                                  absent = false;
                                });
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Radio(
                              activeColor: Colors.blue,
                              value: 2,
                              groupValue: SelectedState,
                              onChanged: (val) {
                                setSelectedState(val);
                                setState(() {
                                  absent = true;
                                  present = false;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            MaterialButton(
                minWidth: 130,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.blueGrey,
                child: Text(
                  'ADD',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  if (date == 'Select Date' || date == null) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Select Date !'),
                            ));
                  } else {
                    firestore
                        .collection(widget.uid)
                        .doc('$Days$Months$Years')
                        .set({
                      'Absent': absent,
                      'Present': present,
                      'Day': Days,
                      'Month': Months,
                      'Year': Years,
                    });
                    setState(() {
                      date = 'Select date';
                      Navigator.pop(context);
                    });
                  } //
                }),
          ],
        ),
      ),
    );
  }
}

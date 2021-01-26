import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class specificattendance extends StatefulWidget {
  static String id = 'specificattendance';
  @override
  _specificattendanceState createState() => _specificattendanceState();
}

class _specificattendanceState extends State<specificattendance> {
  String from;
  String to;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Specific Attendance'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
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
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
                minWidth: 120,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.blueGrey,
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {}),
            Divider(
              color: Colors.black,
              indent: 10,
              endIndent: 10,
            )
          ],
        ),
      ),
    ));
  }
}

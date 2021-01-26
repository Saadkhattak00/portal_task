import 'package:flutter/material.dart';
import 'package:portal_task/Admin/Admin.dart';
import 'package:portal_task/Student/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class loginAdmin extends StatefulWidget {
  static String id = 'loginAdmin';

  @override
  _loginAdminState createState() => _loginAdminState();
}

class _loginAdminState extends State<loginAdmin> {
  final firestore = FirebaseFirestore.instance;
  SnackBar snackBar = SnackBar(content: Text("Sorry! Try Again"));
  List<String> list = [];
  bool showspinner = false;
  bool text = true;
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  Icon visibleicon = Icon(Icons.visibility);
  Icon unvisibleicon = Icon(Icons.visibility_off);
  Icon icon = Icon(
    Icons.visibility_off,
  );

  void getid() async {
    var doc = await firestore.collection('users').get();
    for (var i in doc.docs) {
      list.add(i.id);
    }
  }

  @override
  void initState() {
    getid();
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
          // resizeToAvoidBottomInset: true,
          body: Builder(builder: (context) {
        return ModalProgressHUD(
          inAsyncCall: showspinner,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
          ),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/admin.jpg'),
              )),
            ),
            ListView(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Admin Portal',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    // Email TextField ------->
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54),
                      width: 340,
                      height: 60,
                      child: TextField(
                        onChanged: (String value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            focusColor: Colors.black,
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            labelText: 'Enter your Email',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Password TextField ------->
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54),
                      width: 340,
                      height: 60,
                      child: TextField(
                        onChanged: (String value) {
                          password = value;
                        },
                        obscureText: text,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (text == true) {
                                    text = false;
                                    icon = visibleicon;
                                  } else {
                                    text = true;
                                    icon = unvisibleicon;
                                  }
                                });
                              },
                              icon: icon,
                              color: Colors.black,
                            ),
                            focusColor: Colors.black,
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.security_outlined,
                              color: Colors.black,
                            ),
                            labelText: 'Enter your Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
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
                          'login',
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () async {
                          setState(() {
                            showspinner = true;
                          });
                          try {
                            final user = await auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            final currentuser = auth.currentUser.email;
                            if (currentuser == "admin@email.com") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Admin(
                                  fatchlist: list,
                                );
                              }));
                            }
                            setState(() {
                              showspinner = false;
                            });
                          } catch (e) {
                            print(e);
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              showspinner = false;
                            });
                          }
                        }),
                    SizedBox(
                      height: 60,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, login.id);
                      },
                      child: Text(
                        'Student Portal',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        );
      })),
    ));
  }
}

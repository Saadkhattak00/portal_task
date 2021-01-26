import 'package:flutter/material.dart';
import 'package:portal_task/Admin/loginAdmin.dart';
import 'package:portal_task/Student/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// Future<void> userSetup(String Name) {
//   CollectionReference user = FirebaseFirestore.instance.collection('Name');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = auth.currentUser.uid.toString();
//   String Email = auth.currentUser.email.toString();
//   user.add({'Name': Name, 'Email': Email});
// }

class signup extends StatefulWidget {
  static String id = 'signup';

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final firebase = FirebaseFirestore.instance;
  bool showspinner = false;
  SnackBar snackBar =
      SnackBar(content: Text("Something went Wrong! Try Again"));
  String email;
  String password;
  String name;
  final auth = FirebaseAuth.instance;
  bool text = true;
  Icon visibleicon = Icon(Icons.visibility);
  Icon unvisibleicon = Icon(Icons.visibility_off);
  Icon icon = Icon(Icons.visibility_off);
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
          body: Builder(
        builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: showspinner,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/student.jpg'),
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
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Student Portal',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      // Name TextField ------->
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54),
                        width: 340,
                        height: 60,
                        child: TextField(
                          onChanged: (String value) {
                            name = value;
                          },
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.perm_identity,
                                color: Colors.black,
                              ),
                              labelText: 'Enter your Name',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                            'SignUp',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () async {
                            setState(() {
                              showspinner = true;
                            });
                            try {
                              final user =
                                  await auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              final CurrentUser =
                                  FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                firebase
                                    .collection(CurrentUser.uid)
                                    .doc('Profile')
                                    .set({
                                  'Email': email,
                                  'Name': name,
                                });
                                firebase
                                    .collection('users')
                                    .doc(CurrentUser.uid)
                                    .set({});
                              }

                              if (user != null) {
                                Navigator.pushNamed(context, login.id);
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
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, login.id);
                        },
                        child: Text(
                          'Existing Account?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, loginAdmin.id);
                        },
                        child: Text(
                          'Admin portal',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          );
        },
      )),
    ));
  }
}

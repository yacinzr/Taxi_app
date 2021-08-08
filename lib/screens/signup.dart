import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxiapp/main.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameTextEditingControlLer = TextEditingController();

  TextEditingController emailTextEditingControlLer = TextEditingController();

  TextEditingController passwordTextEditingControlLer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(children: [
          Container(
            height: 300.0,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/logo.png'))),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: nameTextEditingControlLer,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: emailTextEditingControlLer,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "enter your email",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordTextEditingControlLer,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: OutlinedButton(
              onPressed: () {
                if (nameTextEditingControlLer.text.length < 4) {
                  displaytoastmessage("name less than 4 caracters", context);
                } else {
                  registerNewUser(context);
                }
              },
              child: Text(" create an account "),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text(
                  " You have an acount ? Login",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ])));
  }

  final FirebaseAuth _forebaseauth = FirebaseAuth.instance;

  registerNewUser(BuildContext context) async {
    final User user = (await _forebaseauth.createUserWithEmailAndPassword(
            email: emailTextEditingControlLer.text,
            password: passwordTextEditingControlLer.text))
        .user;

    if (user != null) {
      Map userdatamap = {
        "name": nameTextEditingControlLer.text.trim(),
        "email": emailTextEditingControlLer.text.trim(),
        "passeword": passwordTextEditingControlLer.text.trim(),
      };
      usersref.child(user.uid).set(userdatamap);
      displaytoastmessage("user created", context);
      Navigator.pushNamed(context, "/home");
    } else {
      displaytoastmessage("user has nort been created", context);
    }
  }
}

displaytoastmessage(String msg, BuildContext context) {
  Fluttertoast.showToast(msg: msg);
}

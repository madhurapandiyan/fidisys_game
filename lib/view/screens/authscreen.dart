import 'package:fidisys_game/controller/provider/authprovider.dart';
import 'package:fidisys_game/view/screens/homescreen.dart';
import 'package:fidisys_game/view/widget/authwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Authscreen extends StatefulWidget {
  static const routename = "/authscreen";
  Authscreen({Key? key}) : super(key: key);

  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  var isloading = false;
  Future<void> signinmethod(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      setState(() {
        isloading = !isloading;
      });
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushNamed(Homescreen.routename);
      setState(() {
        isloading = !isloading;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isloading = !isloading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Fidisys Games",
                  style: theme.textTheme.headline1,
                ),
                SizedBox(
                  height: 150.h,
                ),
                Text("Log In", style: theme.textTheme.headline2),
                SizedBox(
                  height: 50.h,
                ),
                Authwidget(signinmethod, isloading)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

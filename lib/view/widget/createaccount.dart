import 'package:fidisys_game/view/screens/authscreen.dart';
import 'package:fidisys_game/view/screens/homescreen.dart';
import 'package:fidisys_game/view/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class createaccount extends StatefulWidget {


  @override
  State<createaccount> createState() => _createaccountState();
}

class _createaccountState extends State<createaccount> {
  var email;

  var password;
  var viewpass = true;

  var formkey = GlobalKey<FormState>();
  bool isload = false;

  var emailvalidation = MultiValidator([
    RequiredValidator(errorText: "This field is required"),
    EmailValidator(errorText: "Email not valid")
  ]);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                width: 370.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: theme.accentColor),
                child: Center(
                  child: TextFormField(
                    cursorColor: Color(0XFFFCBC3C),
                    style: theme.textTheme.overline,
                    onSaved: (value) {
                      email = value;
                    },
                    validator: emailvalidation,
                    decoration: InputDecoration(
                        errorStyle: theme.textTheme.overline,
                        hintText: "Email",
                        hintStyle: theme.textTheme.bodyText2,
                        contentPadding: EdgeInsets.only(left: 20.w),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 370.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: theme.accentColor),
                child: Center(
                  child: TextFormField(
                    obscureText: viewpass ? true : false,
                    cursorColor: Color(0XFFFCBC3C),
                    style: theme.textTheme.overline,
                    onSaved: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          enableFeedback: false,
                          splashRadius: 2,
                          onPressed: () {
                            setState(() {
                              viewpass = !viewpass;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: theme.textTheme.bodyText2,
                        contentPadding: EdgeInsets.only(left: 20.w, top: 10.h),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              isload
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      borderRadius: BorderRadius.circular(25.r),
                      onTap: () {
                        setState(() {
                          isload = !isload;
                        });
                        try {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                          }
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.of(context).pushNamed(Homescreen.routename);
                          setState(() {
                            isload = !isload;
                          });
                        } catch (e) {
                          setState(() {
                            isload = !isload;
                          });
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      hoverColor: theme.primaryColorLight,
                      child: Buttonwidget(
                        "Create an account",
                      ),
                    ),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Authscreen.routename);
                  },
                  icon: const Icon(
                    Icons.login_sharp,
                    color: Colors.amber,
                    size: 30,
                  ),
                  label: Text(
                    "Already have an account",
                    style: theme.textTheme.overline,
                  ))
            ],
          )),
    );
  }
}

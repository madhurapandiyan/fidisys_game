import 'dart:io';

import 'package:fidisys_game/controller/provider/categoryprovider.dart';
import 'package:fidisys_game/controller/provider/gameprovider.dart';
import 'package:fidisys_game/view/screens/homescreen.dart';
import 'package:fidisys_game/view/widget/button.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Formwidget extends StatefulWidget {
  @override
  _FormwidgetState createState() => _FormwidgetState();
}

class _FormwidgetState extends State<Formwidget> {
  Object? chossevalue;
  File? uploadedimg;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? name;
  String? des;
  String? url;
  String? playercount;
  String? maxicount;
  bool isloading = false;

  var required = RequiredValidator(errorText: "This field is required");

  Future<void> pickimg() async {
    final picker = ImagePicker();
    final pickedimage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadedimg = File(pickedimage!.path);
    });
  }

  Future<void> onsave() async {
    // print(name);
    // print(des);
    // print(url);
    // print(playercount);
    // print(maxicount);

    final valid = formkey.currentState!.validate();
    print(valid);
    if (valid) {
      formkey.currentState!.save();
      setState(() {
        isloading = !isloading;
      });
      await Provider.of<Gameprovider>(context, listen: false).submitdata(
          DateTime.now().toString(),
          name,
          des,
          url,
          int.parse(playercount!),
          int.parse(maxicount!),
          chossevalue.toString(),
          "mappiy",
          uploadedimg);
      setState(() {
        isloading = !isloading;
      });
      Navigator.of(context).pushNamed(Homescreen.routename);
    }
  }

  var isinit = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isinit) {
      Provider.of<Gameprovider>(context).getcategory();
      isinit = !isinit;
    }
     isinit = !isinit;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
   
    return Form(
        key: formkey,
        child: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name of the Game"),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      width: 370.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: theme.accentColor),
                      child: TextFormField(
                        onSaved: (value) {
                          name = value;
                        },
                        validator: required,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 20.w,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("Description"),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      width: 370.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: theme.accentColor),
                      child: TextFormField(
                        onSaved: (value) {
                          des = value;
                          print(des);
                        },
                        validator: required,
                        maxLines: 20,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 20.w, top: 10.h)),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("Game URL"),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      width: 370.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: theme.accentColor),
                      child: TextFormField(
                        onSaved: (value) {
                          url = value;
                          print(url);
                        },
                        validator: required,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 20.w,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Players Count "),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text("Players\nCount "),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Container(
                                  //margin: EdgeInsets.only(top: 5.h),
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: theme.accentColor),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      playercount = value;
                                      print(value);
                                    },
                                    // validator: required,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text("Maximum\nCount"),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: theme.accentColor),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      maxicount = value;
                                      print(maxicount);
                                    },
                                    // validator: required,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Category"),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 370.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: theme.accentColor),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text(
                              "Category",
                              style: theme.textTheme.subtitle1,
                            ),

                            borderRadius: BorderRadius.circular(20.r),
                            iconSize: 30,
                            style: theme.textTheme.subtitle1,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: theme.buttonColor,
                            ),
                            elevation: 0,

                            // isDense: true,
                            value: chossevalue,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                chossevalue = value.toString();
                                print(value.toString());
                              });
                            },

                            isExpanded: true,
                            dropdownColor: theme.primaryColor,

                            items: Provider.of<Gameprovider>(context)
                                .cat
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(e.toString())))
                                .toList(),
                          ),
                        )),
                    SizedBox(
                      height: 30.h,
                    ),
                    uploadedimg == null
                        ? InkWell(
                            onTap: () {
                              pickimg();
                              print("xsdgv");
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 5.h),
                                width: 300.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: theme.accentColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.file_upload_outlined,
                                      color: theme.buttonColor,
                                    ),
                                    const Text("Upload an image")
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  width: 200.w,
                                  height: 200.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(uploadedimg!),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: theme.buttonColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: pickimg,
                                      icon: Icon(
                                        Icons.change_circle,
                                        color: theme.buttonColor,
                                        size: 40,
                                      )),
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () => onsave(),
                      child: Center(child: Buttonwidget("Submit")),
                    )
                  ],
                ),
              ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buttonwidget extends StatelessWidget {
  final String buttonfield;
  Buttonwidget(this.buttonfield);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: 250.w,
      height: 65.h,
      decoration: BoxDecoration(
          color: theme.buttonColor, borderRadius: BorderRadius.circular(25.r)),
      child: Center(
        child: Text(buttonfield,style: theme.textTheme.button,),
      ),
    );
  }
}

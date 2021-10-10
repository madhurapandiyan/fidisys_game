import 'package:fidisys_game/controller/provider/gameprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Object? chossevalue;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
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
               chossevalue = value;
              Provider.of<Gameprovider>(context,listen: false).getgames(value.toString());
            
            },

            isExpanded: true,
            dropdownColor: theme.primaryColor,

            items: Provider.of<Gameprovider>(context)
                .cat
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.toString())))
                .toList(),
          ),
        ));
  }
}

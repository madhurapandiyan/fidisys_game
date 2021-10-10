import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cardwidget extends StatelessWidget {
  String? title;
  String? des;
  int? playercount;
  int? maxicount;
  String? imgurl;

  Cardwidget(
      {required this.title,
      required this.des,
      required this.imgurl,
      required this.maxicount,
      required this.playercount});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: 570.w,
      height: 200.h,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.accentColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(imgurl!)),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              SizedBox(
                height: 10.h,
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.amber,
                  ),
                  label: Text(
                    "243",
                    style: theme.textTheme.bodyText1,
                  ))
            ],
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                height: 45.h,
                child: Text(
                  title!,
                  style: theme.textTheme.headline1,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              Container(
                width: 225.w,
                height: 60.h,
                child: Text(
                  des!,
                  style: theme.textTheme.bodyText1,
                  //overflow: TextOverflow.ellipsis,

                  //softWrap: true,
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border:
                            Border.all(color: theme.buttonColor, width: 1.5),
                        color: theme.accentColor),
                    child: Center(
                        child: FlatButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Play",
                              style: theme.textTheme.bodyText1,
                            ))),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.supervised_user_circle,
                      color: Colors.white,
                    ),
                    label: Text(
                      "$playercount - $maxicount \nPlayers",
                      style: theme.textTheme.bodyText1,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:fidisys_game/controller/provider/gameprovider.dart';
import 'package:fidisys_game/view/screens/addgamesscreen.dart';
import 'package:fidisys_game/view/screens/authscreen.dart';
import 'package:fidisys_game/view/screens/createscreen.dart';
import 'package:fidisys_game/view/screens/homescreen.dart';
import 'package:fidisys_game/view/widget/createaccount.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Gameprovider()),
        ],
        child: MaterialApp(
          //locale: DevicePreview.locale(context),
          //builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: const Color(0xFF1A121E),
              accentColor: const Color(0xFF292333),
              buttonColor: Color(0XFFFCBC3C),
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                      color: Color(0XFFFEFEFE),
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      //height: 30,
                      fontSize: 30.sp),
                  headline2: TextStyle(
                      color: Color(0XFFFEFEFE),
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      //height: 30,
                      fontSize: 30.sp),
                  bodyText2: TextStyle(
                      color: Color(0x80FFFFFF),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300,
                      fontSize: 20.sp),
                  bodyText1: TextStyle(
                      color: Color(0x80FFFFFF),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp),
                  headline6: TextStyle(
                      color: Color(0x80FFFFFF),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp),
                  button: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp),
                  overline: TextStyle(
                      color: Color(0XFFFCBC3C),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      wordSpacing: 0.w,
                      fontSize: 15),
                  subtitle1: TextStyle(
                      color: Color(0XFFFCBC3C),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      wordSpacing: 0.w,
                      fontSize: 15))),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Homescreen();
              }
              return Authscreen();
            },
          ),
          // FutureBuilder(
          //   future: uid(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.hasData) {
          //       return Homescreen();
          //     } else {
          //       return Authscreen();
          //     }
          //   },
          // ),

          routes: {
            Authscreen.routename: (ctx) => Authscreen(),
            Homescreen.routename: (ctx) => const Homescreen(),
            Addgames.routename: (ctx) => Addgames(),
            Createscreen.routename: (ctx) => Createscreen()
          },
        ),
      ),
    );
  }
}

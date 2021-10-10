import 'package:fidisys_game/controller/provider/categoryprovider.dart';
import 'package:fidisys_game/controller/provider/gameprovider.dart';
import 'package:fidisys_game/view/screens/addgamesscreen.dart';
import 'package:fidisys_game/view/screens/authscreen.dart';
import 'package:fidisys_game/view/widget/button.dart';
import 'package:fidisys_game/view/widget/cradwidget.dart';
import 'package:fidisys_game/view/widget/dropdownwid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum categoryitem { arcade, adventure, actions, casino, racing, sports }

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);
  static const routename = "/homescreen";

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Future? test;
  var isinit = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isinit) {
      test = Provider.of<Gameprovider>(context).getgames("All");
      Provider.of<Gameprovider>(context).getcategory();
      isinit = false;
    }
    isinit = false;
  }

  @override
  Widget build(BuildContext context) {
    final gameprov = Provider.of<Gameprovider>(context);
    final categorygames = Provider.of<Gameprovider>(context).cat;
    final listdata = gameprov.items;
    print(listdata);
    var theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "FidiGames",
          style: theme.textTheme.headline1,
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed(Authscreen.routename);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: test,
          //initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //print(snapshot.data);

            return Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dropdown(),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        listdata.length == 0
                            ? const Center(
                                child: Text("Add more games to view"),
                              )
                            : Column(
                                children: List.generate(
                                    listdata.length,
                                    (i) => Cardwidget(
                                        title: listdata[i].name,
                                        des: listdata[i].description,
                                        imgurl: listdata[i].imgurl,
                                        maxicount: listdata[i].maximumcount,
                                        playercount: listdata[i].playercount)))
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(Addgames.routename),
                          child: Buttonwidget("Add button")))
                ]);
          }),
    ));
  }
}

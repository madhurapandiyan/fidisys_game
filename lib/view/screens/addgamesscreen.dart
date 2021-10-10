import 'package:fidisys_game/view/widget/formwidget.dart';
import 'package:flutter/material.dart';

class Addgames extends StatefulWidget {
  static const routename = "/addgame";
  Addgames({Key? key}) : super(key: key);

  @override
  _AddgamesState createState() => _AddgamesState();
}

class _AddgamesState extends State<Addgames> {
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(child: Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios) ,onPressed: (){},),
        backgroundColor: theme.primaryColor,
        title: Text("Add a Game",style: theme.textTheme.headline1,),
        elevation: 0,
        
      ),
      body: SingleChildScrollView(child: Formwidget()),
   
    ));
  }
}
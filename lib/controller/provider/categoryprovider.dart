// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fidisys_game/controller/provider/gameprovider.dart';
// import 'package:fidisys_game/view/screens/homescreen.dart';

// import 'package:flutter/cupertino.dart';

// class categoryprovider with ChangeNotifier {
//   List<dynamic> _category = [];
//   List<dynamic> get cat {
//     return [..._category];
//   }

//   Future<void> getcategory() async {
//     final firestore = FirebaseFirestore.instance;
//     final collectiondata =
//         await firestore.collection("catagory").doc("1234567890").get();
//     _category = collectiondata.data()!["cato"];
//     notifyListeners();
//   }

//   void filterbycategory(categoryitem value) {
//     if (value == categoryitem.arcade) {
      
//     }
//   }
// }

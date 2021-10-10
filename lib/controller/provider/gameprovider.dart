import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fidisys_game/controller/model/gamemodel.dart';
import 'package:fidisys_game/view/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Gameprovider with ChangeNotifier {
  List<Game> _items = [];

  List<Game> get items {
    return [..._items];
  }

  List<dynamic> _category = [];
  List<dynamic> get cat {
    return [..._category, "All"];
  }

  Future<void> getcategory() async {
    final firestore = FirebaseFirestore.instance;
    final collectiondata =
        await firestore.collection("catagory").doc("1234567890").get();
    _category = collectiondata.data()!["cato"];
    notifyListeners();
  }



  Future<void> submitdata(
      String? id,
      String? name,
      String? description,
      String? url,
      int? playercount,
      int? maximumcount,
      String? category,
      String? imgurl,
      File? image) async {
    List<Game> dummy = [];
    final uniqueid = DateTime.now().toIso8601String().toString();
    final storage = FirebaseStorage.instance;
    final path = storage.ref("Games/$uniqueid.jpg");

    final imagefolder = await path.putFile(image!);
    String downloadurl = await path.getDownloadURL();

    final firestore = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    firestore.collection("games").doc().set({
      "uid": uid,
      "name": name,
      "des": description,
      "url": url,
      "category": category,
      "playercount": playercount,
      "maxicount": maximumcount,
      "imgurl": downloadurl,
    });

    final responce = await firestore.collection("games").get();

    final listofdata = responce.docs.forEach((e) {
      var data = e;
      Game newgame = Game(
          id: data.id,
          name: data.data()["name"],
          description: data.data()["des"],
          url: data.data()["url"],
          playercount: data.data()["playercount"],
          maximumcount: data.data()["maxicount"],
          category: data.data()["category"],
          imgurl: data.data()["imgurl"]);

      dummy.add(newgame);
    });
    _items = dummy;
    print(_items.first.category);

    notifyListeners();
  }



  Future getgames(String value) async {
    //print("mappiy");
    List<Game> dummy = [];
    var firestore;
    if (value == "All") {
      firestore = FirebaseFirestore.instance.collection("games");
    } else {
      firestore = FirebaseFirestore.instance
          .collection("games")
          .where("category", isEqualTo: value);
    }

    try {
      final responce = await firestore.get();

      responce.docs.forEach((element) {
        var gamedata = element;
        Game newgame = Game(
          id: gamedata.id,
          name: gamedata.data()["name"],
          description: gamedata.data()["des"],
          url: gamedata.data()["url"],
          playercount: gamedata.data()["playercount"],
          maximumcount: gamedata.data()["maxicount"],
          category: gamedata.data()["category"],
          imgurl: gamedata.data()["imgurl"],
        );
        dummy.add(newgame);
      });
      _items = dummy;
      // print(dummy[1].name);
      notifyListeners();
      return dummy;
    } catch (e) {
      print(e.toString());
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// class Authprovider with ChangeNotifier {
//   String? uid;

//   Future<void> login(String mail, String pswd) async {
//     final auth = FirebaseAuth.instance;
//     await auth.createUserWithEmailAndPassword(email: mail, password: pswd);
//     uid = auth.currentUser!.uid;
//     notifyListeners();
//   }

//   Future<void> logout() async {
//     await FirebaseAuth.instance.signOut();
//     uid = null;
//     notifyListeners();
//   }
// }

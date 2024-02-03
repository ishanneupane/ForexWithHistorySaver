import 'package:flutter/material.dart';
import 'package:hh/src/calculator/dbhelper/sql_history.dart';
import 'package:hh/src/forex/dbhelper/forex_db.dart';
import 'dart:async';

import '../forex/forex_ui.dart';

class SplashState extends ChangeNotifier {
  late BuildContext context;
  // SplashState() {
  //   late String splashText = "Easy Marketing";
  // } //yessai ho yo tara uta consumer ma state.splash text garna payo
  set getContext(value) {
    context = value;
    checkState();
  }

  void checkState() async {
    SqlHistory.deleteAll();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}

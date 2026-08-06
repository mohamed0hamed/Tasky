import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';

class HomeController  extends ChangeNotifier {
  // HomeController() {
  //   init();
  // }
 String? fullName = 'Guest';
  String? userIamge;
  bool isLoading = false;

  void init() {
    getUserData();
  }
  void getUserData()  {
      fullName = PreferenceManager().getString(StorageKey.userName) ?? 'Guest';
      userIamge = PreferenceManager().getString(StorageKey.userImage);
  }
}
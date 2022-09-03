

import 'package:flutter/material.dart';
import '../../di/di.dart';
import '../../model/database/databaseModel/LoginDetail.dart';
import '../../model/database/dbHelper.dart';
import '../../utils/PakageInfoHelper.dart';

class LoginPageProvider extends ChangeNotifier {

  String? version = "";
  PackageInfoHelper packageInfoHelper = getIt();
  bool isLoading = false;
  bool isPasswordTyped = false;
  bool isPasswordHide = true;

  void getAppVersion() async {
    version = await packageInfoHelper.getVersion();
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setIsPasswordTyped(bool isTyped) {
    isPasswordTyped = isTyped;
    notifyListeners();
  }

  void setIsPasswordHide() {
    isPasswordHide = !isPasswordHide;
    notifyListeners();
  }

  void updateLoginDetailInDB() async {
    DBHelper.instance.updateLoginDetailTable(new LoginDetail(1, true));
    var loginDetail = await DBHelper.instance.readLoginDetail(1);
  }
}
import 'package:createstation/authandbuttons/logincreate.dart';
import 'package:createstation/bookingmodel.dart';
import 'package:createstation/controller/authmodel.dart';
import 'package:createstation/homescreeb/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'httpres.dart';

class OnBoardNotifier extends ChangeNotifier {
  late Future<List<UserModel>> bookingData;
  createStation(CreateStation model) {
    AuthHelper.createStation(model).then((response) {
      if (response) {
        Get.back();
        print(response);
        Get.snackbar("done", "Your are done");

        Get.to(() => StationLoginScreen());
      } else if (!response) {
        Get.snackbar("error", "error");
      }
    }).catchError((error) {
      print(model.toJson());
      print(error);
      Get.snackbar(' failed', 'Invalid');
    });
  }

  Future<void> getbootking(String phonenumber) async {
    bookingData = AuthHelper.Getbooking(phonenumber); // Change this line
  }
}

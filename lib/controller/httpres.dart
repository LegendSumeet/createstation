import "dart:convert";

import "package:createstation/bookingmodel.dart";
import "package:createstation/controller/authmodel.dart";
import "package:createstation/model/bookingmodel.dart";
import "package:http/http.dart" as https;

import "../cibnst.dart";

class AuthHelper {
  static var client = https.Client();

  static Future<bool> createStation(CreateStation model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.https(
        Server.url, "/createstation/station");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }


  static Future<List<UserModel>> Getbooking(String phonenumber) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.https(Server.url,
        "/createbooking/adminbooking/$phonenumber");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var surajData = userModelFromJson(response.body);
      return surajData;
    } else {
      print(response.body);
      return [];
    }
  }
}
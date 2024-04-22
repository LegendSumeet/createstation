import "dart:convert";

import "package:createstation/controller/authmodel.dart";
import "package:http/http.dart" as http;

class AuthHelper {
  static var client = http.Client();

  static Future<bool> createStation(CreateStation model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.http(
        "16.171.199.244:5001", "/createstation/station");

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
}
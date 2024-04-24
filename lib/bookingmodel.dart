// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String id;
  String name;
  String phone;
  String address;
  String stationName;
  String price;
  String time;
  String date;
  String admin;
  int v;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.stationName,
    required this.price,
    required this.time,
    required this.date,
    required this.admin,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    stationName: json["stationName"],
    price: json["price"],
    time: json["time"],
    date: json["date"],
    admin: json["admin"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "address": address,
    "stationName": stationName,
    "price": price,
    "time": time,
    "date": date,
    "admin": admin,
    "__v": v,
  };
}

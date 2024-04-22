// To parse this JSON data, do
//
//     final createStationRes = createStationResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateStationRes createStationResFromJson(String str) => CreateStationRes.fromJson(json.decode(str));

String createStationResToJson(CreateStationRes data) => json.encode(data.toJson());

class CreateStationRes {
  final String name;
  final String address;
  final double price;
  final double latitude;
  final double longitude;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String ownerPassword;
  final bool isapproved;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CreateStationRes({
    required this.name,
    required this.address,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.ownerPassword,
    required this.isapproved,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateStationRes.fromJson(Map<String, dynamic> json) => CreateStationRes(
    name: json["name"],
    address: json["address"],
    price: json["price"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    ownerName: json["ownerName"],
    ownerPhone: json["ownerPhone"],
    ownerEmail: json["ownerEmail"],
    ownerPassword: json["ownerPassword"],
    isapproved: json["isapproved"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "price": price,
    "latitude": latitude,
    "longitude": longitude,
    "ownerName": ownerName,
    "ownerPhone": ownerPhone,
    "ownerEmail": ownerEmail,
    "ownerPassword": ownerPassword,
    "isapproved": isapproved,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

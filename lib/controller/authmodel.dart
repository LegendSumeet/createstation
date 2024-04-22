// To parse this JSON data, do
//
//     final createStation = createStationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateStation createStationFromJson(String str) => CreateStation.fromJson(json.decode(str));

String createStationToJson(CreateStation data) => json.encode(data.toJson());

class CreateStation {
  final String name;
  final String address;
  final String price;
  final String latitude;
  final String longitude;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String ownerPassword;
  final String plugs;

  CreateStation({
    required this.name,
    required this.address,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.ownerPassword,
    required this.plugs,
  });

  factory CreateStation.fromJson(Map<String, dynamic> json) => CreateStation(
    name: json["name"],
    address: json["address"],
    price: json["price"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    ownerName: json["ownerName"],
    ownerPhone: json["ownerPhone"],
    ownerEmail: json["ownerEmail"],
    ownerPassword: json["ownerPassword"],
    plugs: json["plugs"],
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
    "plugs": plugs,
  };
}

import 'dart:convert';

import 'package:createstation/authandbuttons/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  final String id;
  const HomeScreen({super.key, required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    createStation();
    super.initState();
  }


 String responseString = '';
  String stationName = '';
  String stationAddress = '';
  int stationPrice = 0;
  double stationLatitude = 0;
  double stationLongitude = 0;
  String ownerName = '';
  String ownerPhone = '';
  String ownerEmail = '';
  String ownerPassword = '';
  bool isApproved = false;
  String plugs = '';

  Future<void> createStation() async {
    final String url = 'http://16.171.199.244:5001/createstation/station/${widget.id}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        responseString = json.encode(responseData);
        stationName = responseData['name'];
        stationAddress = responseData['address'];
        stationPrice = responseData['price'];
        stationLatitude = responseData['latitude'];
        stationLongitude = responseData['longitude'];
        ownerName = responseData['ownerName'];
        ownerPhone = responseData['ownerPhone'];
        ownerEmail = responseData['ownerEmail'];
        ownerPassword = responseData['ownerPassword'];
        isApproved = responseData['isapproved'];
        plugs = responseData['plugs'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Station Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('UID');
          prefs.setBool('isStation',false);
          Get.offAll(()=>MainScreen() );

        },
        child: const Icon(Icons.login_outlined),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Text('Station Name: $stationName'),
          Text('Station Address: $stationAddress'),
          Text('Station Price: $stationPrice'),
          Text('Station Latitude: $stationLatitude'),
          Text('Station Longitude: $stationLongitude'),
          Text('Owner Name: $ownerName'),
          Text('Owner Phone: $ownerPhone'),
          Text('Owner Email: $ownerEmail'),
          Text('Owner Password: $ownerPassword'),
          Text('Is Approved: $isApproved'),
          Text('Plugs: $plugs'),
        ],
      )
    );
  }
}

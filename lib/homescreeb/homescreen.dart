import 'dart:convert';

import 'package:createstation/authandbuttons/auth.dart';
import 'package:createstation/bookingscreen.dart';
import 'package:createstation/cards.dart';
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

  bool checkdata = false;
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
    final String url =
        'https://greenchargehub.vercel.app/createstation/station/${widget.id}';

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
      setState(() {
        checkdata = true;
      });
      Get.snackbar('Error', 'Failed to load station details');
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
            prefs.setBool('isStation', false);
            Get.offAll(() => MainScreen());
          },
          child: const Icon(Icons.login_outlined),
        ),
        body: (checkdata == false)
            ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_city),
                      title: const Text('Station Name'),
                      subtitle: Text('$stationName'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Station Address'),
                      subtitle: Text('$stationAddress'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text('Price'),
                      subtitle: Text('$stationPrice'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.power),
                      title: const Text('Plugs'),
                      subtitle: Text('$plugs'),
                    ),
                  ),
                  (isApproved==false)?const Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Review Status'),
                      subtitle: Text(
                          "Your Station is in Review, Please wait for approval."),
                      trailing: CircularProgressIndicator(),
                    ),
                  ):const Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Review Status'),
                      subtitle: Text(
                          "Your Station is Approved, You can now take bookings."),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.scatter_plot),
                    title: const Text('Get Bookings'),
                    subtitle: ElevatedButton(
                      onPressed: () {
                        Get.to(() => BookingView(phonenumber: widget.id));
                      },
                      child: const Text('Bookings'),
                    ),
                  ),

                ],
              ),
            )
            : const Center(
                child: Card(
                  child: ListTile(
                    title: Text(
                        'Your Station application is rejected, Please try again.'),
                  ),
                ),
              ));
  }
}

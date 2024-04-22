import 'package:createstation/authandbuttons/logincreate.dart';
import 'package:createstation/getlocation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:developer' as devtools;
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charging App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
               Position live = await determinePosition();

                double latitude = live.latitude;
                double longitude = live.longitude;

                String latitudeString = latitude.toString();
                String longitudeString = longitude.toString();

                devtools.log(live.toString());
                Get.to(() => CreateStationScreen(
                  latitude: latitudeString,
                  longitude: longitudeString,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: const Text(
                'Create Station',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Get.to(() => StationLoginScreen());
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                side: const BorderSide(color: Colors.blue),
              ),
              child: const Text(
                'Login Station',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

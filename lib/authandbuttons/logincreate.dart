import 'dart:convert';

import 'package:createstation/controller/authmodel.dart';
import 'package:createstation/homescreeb/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools;
import '../controller/controller.dart';

class StationLoginScreen extends StatefulWidget {
  @override
  State<StationLoginScreen> createState() => _StationLoginScreenState();
}

class _StationLoginScreenState extends State<StationLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isPasswordVisible = false;

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: !isPasswordVisible,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var response = await http.get(Uri.http("16.171.199.244:5001",
                    "/createstation/station/login/${emailController.text.toString()}/${passwordController.text.toString()}"));
                devtools.log(emailController.text);
                devtools.log(passwordController.text);
                devtools.log(response.toString());
                devtools.log(response.statusCode.toString());
                if (response.statusCode == 200) {
                  final decoded = jsonDecode(response.body);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('UID', decoded['_id']);
                  prefs.setBool('isStation', true);
                  String uid = prefs.getString('UID').toString();
                 Get.offAll(()=>HomeScreen(id: uid));
                } else {
                  // Handle non-200 status code
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login email or password is incorrect. Please try again.'),
                    ),
                  );
                  print("Failed to fetch data. Status code: ${response.statusCode}");
                }
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

class CreateStationScreen extends StatefulWidget {
  final String latitude;
  final String longitude;

  const CreateStationScreen({
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CreateStationScreen> createState() => _CreateStationScreenState();
}

class _CreateStationScreenState extends State<CreateStationScreen> {
  // Define controllers for each TextFormField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController plugsController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when they are no longer needed
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    addressController.dispose();
    priceController.dispose();
    fullnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller:
                    nameController, // Assign controller to TextFormField
                decoration: const InputDecoration(
                  labelText: 'Station Name',
                ),
              ),
              TextFormField(
                controller:
                    fullnameController, // Assign controller to TextFormField
                decoration: const InputDecoration(
                  labelText: 'Owner Name',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    emailController, // Assign controller to TextFormField
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    phoneNumberController, // Assign controller to TextFormField
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    passwordController, // Assign controller to TextFormField
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    addressController, // Assign controller to TextFormField
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    priceController, // Assign controller to TextFormField
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price per kWh',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    plugsController, // Assign controller to TextFormField
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Plugs',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final mentorNotifier =
                      Provider.of<OnBoardNotifier>(context, listen: false);
                  // You can access the text entered in the TextFormFields using the controllers
                  final String name = nameController.text;
                  final String email = emailController.text;
                  final String phoneNumber = phoneNumberController.text;
                  final String password = passwordController.text;
                  final String address = addressController.text;
                  final String price = priceController.text;
                  final String plugs = plugsController.text;

                  CreateStation station = CreateStation(
                      name: name,
                      address: address,
                      price: price.toString(),
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                      plugs: plugs,
                      ownerName: fullnameController.text,
                      ownerPhone: phoneNumber,
                      ownerEmail: email,
                      ownerPassword: password);

                  await mentorNotifier.createStation(station);
                },
                child: const Text('Create Station'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

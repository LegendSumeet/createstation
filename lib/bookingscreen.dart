import 'package:flutter/material.dart';

class BOokingScreens extends StatefulWidget {
  final String id;
  const BOokingScreens({super.key, required this.id});

  @override
  State<BOokingScreens> createState() => _BOokingScreensState();
}

class _BOokingScreensState extends State<BOokingScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Screen'),
      ),
      body: const Center(
        child: Text('This is the booking screen'),
      ),
    );
  }
}

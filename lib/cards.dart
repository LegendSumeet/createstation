import 'package:createstation/bookingmodel.dart';
import 'package:createstation/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingView extends StatefulWidget {
  final String phonenumber;

  const BookingView({super.key, required this.phonenumber});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Booking History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBookingList(context, true),
                  _buildBookingList(context, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(BuildContext context, bool completed) {
    return Consumer<OnBoardNotifier>(
      builder: (context, mentorNotifier, child) {
        mentorNotifier.getbootking(widget.phonenumber);
        return FutureBuilder<List<UserModel>>(
          future: mentorNotifier.bookingData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading......"));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String now = DateTime.now().toString();
              print(now);
              List<UserModel> bookingData = snapshot.data ?? [];

              final filteredData = bookingData.where((booking) {
                DateTime currentTime = DateTime.parse(now);
                DateTime bookingDateTime = DateTime.parse(booking.time);
                return (completed == true)
                    ? bookingDateTime.isAfter(currentTime)
                    : bookingDateTime.isBefore(currentTime);
              }).toList();

              if (filteredData.isEmpty) {
                return Center(
                    child: Text(
                        "No Slots ${completed ? 'Available' : 'Completed'}"));
              }

              // Sort the filtered data by date
              filteredData.sort((a, b) => a.date.compareTo(b.date));

              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  UserModel userModel = filteredData[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChargingStationCard(userModel),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

class ChargingStationCard extends StatelessWidget {
  final UserModel chargingStation;

  const ChargingStationCard(this.chargingStation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 5),
            Text('Name: ${chargingStation.name}'),
            const SizedBox(height: 5),
            Text('PhoneNumber: ${chargingStation.phone}'),
            const SizedBox(height: 5),
            Text('Date: ${chargingStation.date}'),
            const SizedBox(height: 5),
            Text('Time: ${chargingStation.time}'),
          ],
        ),
      ),
    );
  }
}
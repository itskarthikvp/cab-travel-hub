import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CabBookingPage extends StatefulWidget {
  @override
  _CabBookingPageState createState() => _CabBookingPageState();
}

class _CabBookingPageState extends State<CabBookingPage> {
  DateTime? _selectedDate = DateTime.now();
  late String _selectedPickupPoint = 'Point A'; // Use a default value
  int totalSeats = 11; // Replace with the actual total number of seats

  List<String> pickupPoints = ['Point A', 'Point B', 'Point C', 'Point D'];
  late bool hasBooked;

  @override
  void initState() {
    super.initState();
    // Check the booking status when the page is initialized
    _checkBookingStatus();
  }

  Future<void> _checkBookingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the booking status, defaulting to false if not set
    bool booked = prefs.getBool('hasBooked') ?? false;
    setState(() {
      hasBooked = booked;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _bookCab() async {
    if (!hasBooked && totalSeats > 0) {
      // Add logic to book the cab with selected date and pickup point

      // Reduce the seat count when the cab is booked
      setState(() {
        totalSeats -= 1;
        hasBooked = true;
      });

      // Save the booking status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasBooked', true);

      // Show a feedback dialog or snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cab booked successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (hasBooked) {
      // Show a message if the user has already booked a cab
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Already Booked'),
            content: Text('You have already booked a cab.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show a message when all seats are booked
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Seats Available'),
            content: Text('Sorry, all seats have been booked for the selected date and pickup point.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cab Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Date',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('Choose Date'),
            ),
            SizedBox(height: 20),
            Text(
              'Select Pickup Point',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedPickupPoint,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPickupPoint = newValue ?? 'Point A'; // Use default if null
                });
              },
              items: pickupPoints.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: GoogleFonts.poppins(fontSize: 16),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Seats Available: $totalSeats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookCab,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Book Cab',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


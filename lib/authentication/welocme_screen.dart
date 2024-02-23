import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabBookingPage extends StatefulWidget {
  @override
  _CabBookingPageState createState() => _CabBookingPageState();
}

class _CabBookingPageState extends State<CabBookingPage> {
  DateTime? _selectedDate = DateTime.now();
  late String _selectedPickupPoint = 'Point A'; // Use a default value
  int totalSeats = 20; // Replace with the actual total number of seats

  List<String> pickupPoints = ['Point A', 'Point B', 'Point C', 'Point D'];

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

  void _bookCab() {
    // Add logic to book the cab with selected date and pickup point

    // Reduce the seat count when the cab is booked
    setState(() {
      totalSeats -= 1;
    });
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
            const SizedBox(height: 20),
            Text(
              'Total Seats Available: $totalSeats',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookCab,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
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




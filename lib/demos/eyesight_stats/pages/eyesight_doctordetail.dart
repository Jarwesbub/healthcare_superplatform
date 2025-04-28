import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/appointmentpage.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/doctorcallpage.dart';

class HorizontalScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class DoctorDetailPage extends StatefulWidget {
  final String doctorName;
  final double rating;
  final int ratingCount;
  final String imagePath;
  final String bio;
  final List<Map<String, dynamic>> reviews;
  final String specialty;
  final String doctorTitle;


  

  const DoctorDetailPage({
    super.key,
    required this.doctorName,
    required this.rating,
    required this.ratingCount,
    required this.imagePath,
    required this.bio,
    required this.reviews,
    required this.specialty,
    required this.doctorTitle,
  
    
  });

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  final List<TimeOfDay> availableTimes = List.generate(
    8,
    (index) => TimeOfDay(hour: 9 + index, minute: 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FF),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 13),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ClipRRect(
                      child: Image.asset(
                        widget.imagePath,
                        width: 200,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 300, 
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 120), 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctorName,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 250, 
                          left: 25,
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Color.fromARGB(255, 114, 223, 238),
                                child: Icon(Icons.check, size: 16, color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Accepting\nNew Patients",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Rating & Review Button Section
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 85, 96, 116),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.remove_red_eye, color: Colors.white, size: 24),
                                  SizedBox(width: 10),
                                  Text('Services', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 220, // Adjust as needed
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'About the Doctor:',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '${widget.doctorTitle} - ${widget.specialty}',
                                    style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.bio,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      // Floating buttons (rating, map)
                      Positioned(
                        top: 0,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  title: const Text("Patient Reviews"),
                                  content: SizedBox(
                                    height: 250,
                                    width: 300,
                                    child: widget.reviews.isNotEmpty
                                        ? SingleChildScrollView(
                                            child: Column(
                                              children: widget.reviews.map((review) {
                                                final index = widget.reviews.indexOf(review);
                                                return ListTile(
                                                  leading: const Icon(Icons.account_circle, color: Colors.blue),
                                                  title: Text("User ${index + 1}"),
                                                  subtitle: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(review['text']),
                                                      const SizedBox(height: 4),
                                                      RatingBarIndicator(
                                                        rating: review['rating'].toDouble(),
                                                        itemBuilder: (context, _) =>
                                                            const Icon(Icons.star, color: Colors.amber),
                                                        itemCount: 5,
                                                        itemSize: 16.0,
                                                        direction: Axis.horizontal,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        : const Center(child: Text("No reviews yet.")),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400, width: 2),
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.rating.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400, width: 2),
                              color: Colors.white,
                            ),
                            child: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.place, color: Colors.grey, size: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Action Buttons
          Positioned(
            bottom: 5,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 42, 135, 172), shape: BoxShape.circle),
              child: const Icon(Icons.chat, color: Colors.white, size: 24),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 15,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 42, 135, 172), shape: BoxShape.circle),
              child: GestureDetector(
                onTap: () {
                  // Navigate to DoctorCallPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorCallPage(
                        imagePath: widget.imagePath,
                        doctorName: widget.doctorName,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.phone, color: Colors.white, size: 24),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 70,
            right: 70,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(
                      doctorName: widget.doctorName,
                      availableTimes: availableTimes,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 42, 135, 172),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Text(
                      'Make an Appointment',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 30,
            left: 20,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                iconSize: 24,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          
          Positioned(
            top: 30,
            right: 20,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: () {
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 70,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.black),
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: () {
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

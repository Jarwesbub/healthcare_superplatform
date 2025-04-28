import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'eyesight_doctordetail.dart';

class MatchingDoctorsPage extends StatelessWidget {
  final List<int> matchingDoctorIndices;
  final List<String> doctorNames;
  final List<String> imageList;
  final List<double> doctorRatings;
  final List<int> doctorRatingCounts;
  final List<String> doctorDescriptions;
  final List<String> doctorTitles;
  final List<String> doctorSpecialties;
  final List<String> doctorBios;
  final List<List<Map<String, dynamic>>> doctorReviews;
  final String selectedServiceName;
  final String selectedServiceImagePath;
  final String selectedServiceDescription;

  const MatchingDoctorsPage({
    super.key,
    required this.matchingDoctorIndices,
    required this.doctorNames,
    required this.imageList,
    required this.doctorRatings,
    required this.doctorRatingCounts,
    required this.doctorDescriptions,
    required this.doctorTitles,
    required this.doctorSpecialties,
    required this.doctorBios,
    required this.doctorReviews,
    required this.selectedServiceName,
    required this.selectedServiceImagePath,
    required this.selectedServiceDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(selectedServiceName),
        backgroundColor: const Color.fromARGB(255, 42, 135, 172),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView( 
        child: Column( 
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: Image.asset(
                selectedServiceImagePath,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                selectedServiceDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Doctors for $selectedServiceName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 42, 135, 172),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            
            ListView.builder(
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              itemCount: matchingDoctorIndices.length,
              itemBuilder: (context, index) {
                final i = matchingDoctorIndices[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailPage(
                          doctorName: doctorNames[i],
                          rating: doctorRatings[i],
                          ratingCount: doctorRatingCounts[i],
                          imagePath: imageList[i],
                          bio: doctorBios[i],
                          reviews: doctorReviews[i], 
                          specialty: doctorSpecialties[i],
                          doctorTitle: doctorTitles[i],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 240, 245),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Image.asset(
                                imageList[i],
                                fit: BoxFit.cover,
                                width: 100,
                                height: 110,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorNames[i],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctorDescriptions[i],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: doctorRatings[i],
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${doctorRatings[i].toStringAsFixed(1)} (${doctorRatingCounts[i]})',
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${doctorTitles[i]} - ${doctorSpecialties[i]}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

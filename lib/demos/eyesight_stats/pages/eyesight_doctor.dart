import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/matching_doctors_page.dart';
import 'eyesight_doctordetail.dart'; 

class EyesightDoctor extends StatefulWidget {
  const EyesightDoctor({super.key});

  @override
  State<EyesightDoctor> createState() => _EyesightDoctorState();
}

class _EyesightDoctorState extends State<EyesightDoctor> {
  bool _showAllServices = false; 
 

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/images/doctor1.png',
      'assets/images/doctor2.png',
      'assets/images/doctor3.png',
      'assets/images/doctor4.png',
    ];

    final List<String> doctorNames = [
      'Dr. Ethan Carter',
      'Dr. Henry Mitchell',
      'Dr. Samuel Smith',
      'Dr. Olivia Hayes',
    ];

    final List<String> doctorBios = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ];

    final List<double> doctorRatings = [4.5, 4.0, 5.0, 3.5];
    final List<int> doctorRatingCounts = [25, 10, 42, 7];

    final List<String> opticServiceNames = [
      'Eye Surgery',
      'Eye checkup',
      'Retina Care',
      'Pediatric Eye Care',
      'Contact Lenses & Glasses',
    ];

    final List<String> opticServiceDescriptions = [
  'Eye surgery involves procedures that correct vision, remove cataracts, or treat injuries and diseases of the eye.',
  'If you are experiencing symptoms of dry eyes, or seeking relief, or want to know if your eyes are dry, you can schedule an appointment at one of our Dry Eye Clinics. Our team of experts specializes in examining the underlying causes of dry eyes and providing effective treatments.',
  'Retina care focuses on diseases and surgery related to the retina and vitreous in the eye.',
  'Pediatric eye care deals with eye health, vision testing, and treatment for children.',
  'Contact lenses & glasses provide non-invasive ways to correct vision using optical aids.',
    ];


    final List<String> doctorTitles = [
      'Eye Surgery',
      'Retina Care',
      'Pediatric Vision',
      'Lens Implants',
    ];

    final List<String> doctorSpecialties = [
      'Specialist',
      'Retina Expert',
      'Children\'s Eye Care',
      'Implant Surgeon',
    ];

    final List<String> doctorDescriptions = [
      '8 years experience',
      '7 years experience',
      '15 years experience',
      '3 years experience',
    ];

    final List<List<Map<String, dynamic>>> doctorReviews = [
      [
        {'text': 'Very professional!', 'rating': 5},
        {'text': 'Explained everything clearly.', 'rating': 4},
        {'text': 'Will come again!', 'rating': 5},
        {'text': 'Friendly and welcoming atmosphere.', 'rating': 4},
      ],
      [
        {'text': 'Helped me with my retina issue.', 'rating': 4},
        {'text': 'Very professional!', 'rating': 5},
        {'text': 'Highly recommend.', 'rating': 4},
      ],
      [
        {'text': 'Great with kids.', 'rating': 5},
        {'text': 'Excellent diagnosis.', 'rating': 5},
        {'text': 'Top-notch service!', 'rating': 5},
      ],
      [
        {'text': 'Didn’t wait long.', 'rating': 3},
        {'text': 'Clean and modern clinic.', 'rating': 4},
        {'text': 'Good experience overall.', 'rating': 4},
      ],
    ];
    
    final List<String> opticServiceImages = [
      'assets/images/surgeryy.png',      // For Eye Surgery
      'assets/images/optoo.jpg',         // For Eye checkup
      'assets/images/retina.jpg',     // For Retina Care
      'assets/images/opto.png',      // For Pediatric Eye Care
      'assets/images/lense.jpeg',        // For Lense
    ];

    final List<List<String>> doctorServices = [
      ['Eye Surgery', 'Eye checkup'], // Dr. Näkö Keke
      ['Retina Care', 'Eye checkup'],       // Dr. Man
      ['Pediatric Eye Care','Eye checkup'],              // Dr. Veeti Visio
      ['Contact Lenses & Glasses','Eye checkup'],        // Dr. Aino Kirkas
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/default.jpg'), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), 

                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi, User!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'How do you feel today?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Meet a Doctor',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            
            ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: List.generate(doctorNames.length, (index) {
                    final String imagePath = imageList[index];
                    final String doctorName = doctorNames[index];
                    final double rating = doctorRatings[index];
                    final int ratingCount = doctorRatingCounts[index];
                    final String bio = doctorBios[index];
                    final String experience = doctorDescriptions[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailPage(
                                doctorName: doctorName,
                                rating: rating,
                                ratingCount: ratingCount,
                                imagePath: imagePath,
                                bio: bio,
                                reviews: doctorReviews[index],
                                specialty: doctorSpecialties[index],
                                doctorTitle: doctorTitles[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 370,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F4FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Image.asset(
                                  imagePath,
                                  width: 180,
                                  height: 180, 
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                              Transform.translate(
                                offset: Offset(-10, 0), 
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      doctorName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      experience,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: rating,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          direction: Axis.horizontal,
                                        ),
                                        const SizedBox(width: 8),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${rating.toStringAsFixed(1)} ',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '($ratingCount)',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 42, 135, 172),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.remove_red_eye,
                                              size: 24,
                                              color: Color.fromARGB(255, 42, 135, 172),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doctorTitles[index],
                                                style: const TextStyle(
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                doctorSpecialties[index],
                                                style: const TextStyle(
                                                  color: Color.fromARGB(255, 240, 236, 236),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Optic Services',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showAllServices = !_showAllServices;
                      });
                    },
                    child: Text(
                      _showAllServices ? 'Show Less' : 'See All',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // Add services section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...List.generate(
                    _showAllServices ? opticServiceNames.length : 2,
                    (index) {
                      final String serviceName = opticServiceNames[index];
                      List<int> filteredDoctorIndices = [];

                      for (int i = 0; i < doctorNames.length; i++) {
                        if (doctorServices[i].contains(serviceName)) {
                          filteredDoctorIndices.add(i);
                        }
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchingDoctorsPage(
                                matchingDoctorIndices: filteredDoctorIndices,
                                doctorNames: doctorNames,
                                imageList: imageList,
                                doctorRatings: doctorRatings,
                                doctorRatingCounts: doctorRatingCounts,
                                doctorDescriptions: doctorDescriptions,
                                doctorTitles: doctorTitles,
                                doctorSpecialties: doctorSpecialties,
                                doctorBios: doctorBios,
                                doctorReviews: doctorReviews,
                                selectedServiceName: opticServiceNames[index],
                                selectedServiceImagePath: opticServiceImages[index],
                                selectedServiceDescription: opticServiceDescriptions[index],
                                
                                
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 180,
                          height: 190,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F4FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  opticServiceImages[index],
                                  width: 160,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, 0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  width: 160,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 18),
                                      Expanded(
                                        child: Text(
                                          serviceName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.north_east,
                                          size: 28,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

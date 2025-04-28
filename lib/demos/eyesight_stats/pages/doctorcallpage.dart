import 'package:flutter/material.dart';

class DoctorCallPage extends StatelessWidget {
  final String imagePath;
  final String doctorName;
  

  const DoctorCallPage({
    super.key,
    required this.imagePath,
    required this.doctorName,
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/blur-hospital.jpg',
          fit: BoxFit.cover,
          ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 170), 
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 640,
                height: 540,
              ),
            ),
          ),
          
          Positioned(
            top: 40,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.black26,
                ),
                child: Image.asset(
                  'assets/images/mann.jpg', 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  doctorName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600,
                        shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 4.0,
                          color: Colors.black54,
                        ),
                      ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '00:45',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400,
                        shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 4.0,
                          color: Colors.black54,
                        ),
                      ],
                  ),
                ),
              ],
            ),
          ),

         
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute
                  _controlButton(
                    icon: Icons.mic_off,
                    color: const Color.fromARGB(255, 116, 111, 106),
                    onTap: () {
                     
                    },
                  ),

                  // Video
                  _controlButton(
                    icon: Icons.videocam,
                    color: const Color.fromARGB(255, 116, 111, 106),
                    onTap: () {
                     
                    },
                  ),

                  // End Call 
                  _controlButton(
                    icon: Icons.call_end,
                    color: const Color.fromARGB(255, 240, 59, 83),
                    onTap: () => Navigator.pop(context),
                  ),

                  // Chat
                  _controlButton(
                    icon: Icons.chat_bubble,
                    color: const Color.fromARGB(255, 116, 111, 106),
                    onTap: () {
                    
                    },
                  ),

                  // Speaker
                  _controlButton(
                    icon: Icons.volume_up,
                    color: const Color.fromARGB(255, 116, 111, 106),
                    onTap: () {
                   
                    },
                  ),
                ],
              ),
            ),
          ),

       
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

        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }
}

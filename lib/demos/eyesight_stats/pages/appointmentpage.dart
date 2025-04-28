import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  final String doctorName;
  final List<TimeOfDay> availableTimes;

  

  const AppointmentPage({
    super.key,
    required this.doctorName,
    required this.availableTimes,

    
  });

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime selectedDate = DateTime.now().toLocal(); 
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 240, 245),
      body: Column(
        children: [
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 135, 172),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Select Date & Time",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        '${widget.doctorName},',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Eye services',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: isWideScreen
                  ? Row(
                      children: [
                        Expanded(child: _buildLeftColumn()),
                        const SizedBox(width: 20),
                        Expanded(child: _buildAvailabilityBox()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildLeftColumn(),
                        const SizedBox(height: 20),
                        _buildAvailabilityBox(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 42, 135, 172), 
              onPrimary: Colors.white, 
            ),
          ),
          child: CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChanged: (date) {
              setState(() {
                selectedDate = date;
                selectedTime = null;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityBox() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today\nAvailability",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.availableTimes.length} slots",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Time slots
          Wrap(
            spacing: 4, 
            runSpacing: 12, 
            children: widget.availableTimes
                .map((time) {
              final isSelected = selectedTime?.hour == time.hour && selectedTime?.minute == time.minute;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = time; 
                  });
                },
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) / 4, 
                  height: 40,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromARGB(255, 42, 135, 172) 
                          : Colors.white, 
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300), 
                    ),
                    child: Text(
                      DateFormat('HH:mm').format(DateTime(0, 1, 1, time.hour, time.minute)), 
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // Confirm button
          ElevatedButton.icon(
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("Confirm Appointment"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 42, 135, 172),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: selectedTime == null
                ? null 
                : () {
                    final dateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Appointment set for ${DateFormat.yMMMMd().format(dateTime)} at ${DateFormat.Hm().format(dateTime)}",
                        ),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}

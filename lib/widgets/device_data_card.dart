import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceDataCard extends StatelessWidget {
  final Device device;

  const DeviceDataCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            child: Row(
              children: [
                Icon(device.icon, size: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      device.manufacturer,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bluetooth_connected,
                        size: 14,
                        color: Colors.green.shade800,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Connected',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDeviceSpecificData(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSpecificData() {
    //switch case for returning data based on connected devices
    switch (device.type) {
      case 'Sports Watch':
        return _buildActivityData();
      case 'Smart Scale':
        return _buildWeightData();
      case 'Health Device':
        return _buildHeartRateData();
      default:
        return const Text('No data available for this device type');
    }
  }

  Widget _buildActivityData() {
    //build the dummy data
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricColumn(Icons.directions_walk, '9,847', 'Steps'),
            _buildMetricColumn(Icons.local_fire_department, '423', 'Calories'),
            _buildMetricColumn(Icons.timer, '54', 'Active Minutes'),
          ],
        ),
        
        const SizedBox(height: 16),
        
        const Text('Daily Goal Progress'),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: 0.73,
          backgroundColor: Colors.grey.shade200,
          color: Colors.green,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
        const SizedBox(height: 4),
        const Text(
          '73% of daily goal',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildWeightData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weight Tracking',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        Center(
          child: Column(
            children: [
              const Text('Current Weight', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text(
                    '70.2',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'kg',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 4),
              
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '0.3 kg this week',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMetricColumn(Icons.monitor_weight, '22.4', 'BMI'),
            const SizedBox(width: 24),
            _buildMetricColumn(Icons.water_drop, '57%', 'Body Water'),
          ],
        ),
      ],
    );
  }

  Widget _buildHeartRateData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Heart Rate',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        Center(
          child: Column(
            children: [
              const Text('Current', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text(
                    '72',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'bpm',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricColumn(Icons.arrow_downward, '54', 'Min'),
            _buildMetricColumn(Icons.trending_up, '68', 'Avg'),
            _buildMetricColumn(Icons.arrow_upward, '136', 'Max'),
          ],
        ),
        
        const SizedBox(height: 16),
        const Text('Heart Rate Zones'),
        const SizedBox(height: 4),
        
        Container(
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rest', style: TextStyle(fontSize: 12)),
            Text('Fat Burn', style: TextStyle(fontSize: 12)),
            Text('Cardio', style: TextStyle(fontSize: 12)),
            Text('Peak', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../models/device.dart';

class AvailableDevicesList extends StatelessWidget {
  final bool isScanning;
  final List<Device> availableDevices;
  final List<Device> connectedDevices;
  final Function(Device) onConnect;

  const AvailableDevicesList({
    super.key,
    required this.isScanning,
    required this.availableDevices,
    required this.connectedDevices,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    if (!isScanning) {
      return const Expanded(
        flex: 2,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Press Scan to search for nearby devices',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      flex: 2,
      child: ListView.builder(
        itemCount: availableDevices.length,
        itemBuilder: (context, index) {
          final device = availableDevices[index];
          // Check if device is already connected
          final bool isConnected = connectedDevices.any((d) => d.id == device.id);
          
          return Card(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: Icon(device.icon, size: 32),
              title: Text(device.name),
              subtitle: Text('${device.manufacturer} • ${device.type}'),
              trailing: isConnected
                  ? const Text('Connected', style: TextStyle(color: Colors.green))
                  : ElevatedButton(
                      onPressed: () => onConnect(device),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        foregroundColor: Colors.blue.shade900,
                      ),
                      child: const Text('Connect'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
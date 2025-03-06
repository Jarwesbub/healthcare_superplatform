import 'package:flutter/material.dart';
import '../models/device.dart';

class ConnectedDevicesList extends StatelessWidget {
  final List<Device> connectedDevices;
  final Function(Device) onDisconnect;
  final Function(Device) onTap;

  const ConnectedDevicesList({
    super.key,
    required this.connectedDevices,
    required this.onDisconnect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (connectedDevices.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'No devices connected',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: connectedDevices.length,
        itemBuilder: (context, index) {
          final device = connectedDevices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: Icon(device.icon, size: 32),
              title: Text(device.name),
              subtitle: Text('${device.manufacturer} • ${device.type}'),
              trailing: ElevatedButton(
                onPressed: () => onDisconnect(device),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  foregroundColor: Colors.red.shade900,
                ),
                child: const Text('Disconnect'),
              ),
              onTap: () => onTap(device),
            ),
          );
        },
      ),
    );
  }
}
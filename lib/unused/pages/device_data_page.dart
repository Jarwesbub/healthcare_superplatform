import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/unused/pages/devices_page.dart';
import '../services/device_storage.dart';
import '../models/device.dart';
import '../widgets/device_data_card.dart';

class DeviceDataPage extends StatefulWidget {
  const DeviceDataPage({super.key});

  @override
  _DeviceDataPageState createState() => _DeviceDataPageState();
}

class _DeviceDataPageState extends State<DeviceDataPage> {
  List<Device> connectedDevices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConnectedDevices();
  }

  Future<void> _loadConnectedDevices() async {
    setState(() {
      isLoading = true;
    });

    try {
      final devices = await DeviceStorage.loadConnectedDevices();
      setState(() {
        connectedDevices = devices;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading devices: $e')));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Device Data'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : connectedDevices.isEmpty
              ? _buildNoDevicesView()
              : _buildDeviceDataView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DevicePage()),
          );
          _loadConnectedDevices();
        },
        child: const Icon(Icons.add),
        tooltip: 'Manage Devices',
      ),
    );
  }

  Widget _buildNoDevicesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bluetooth_disabled, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No devices connected',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the + button to connect your devices',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DevicePage()),
              );
              _loadConnectedDevices();
            },
            icon: const Icon(Icons.add),
            label: const Text('Connect Devices'),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceDataView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: connectedDevices.length,
        itemBuilder: (context, index) {
          final device = connectedDevices[index];
          return DeviceDataCard(device: device);
        },
      ),
    );
  }
}

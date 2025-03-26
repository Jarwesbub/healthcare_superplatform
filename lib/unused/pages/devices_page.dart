import 'package:flutter/material.dart';
import '../widgets/connected_devices_list.dart';
import '../widgets/available_devices_list.dart';
import '../../models/device.dart';
import '../services/device_storage.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  // List of connectable devices (maybe store this data in a JSON at some point to simulate)
  List<Device> connectedDevices = [];
  final List<Device> availableDevices = [
    Device(
      id: '1',
      name: 'Garmin Forerunner 255',
      type: 'Sports Watch',
      manufacturer: 'Garmin',
      connectionStatus: 'Available',
      icon: Icons.watch,
    ),
    Device(
      id: '2',
      name: 'Smart Scale Pro',
      type: 'Smart Scale',
      manufacturer: 'Withings',
      connectionStatus: 'Available',
      icon: Icons.monitor_weight,
    ),
    Device(
      id: '3',
      name: 'Heart Rate Monitor',
      type: 'Health Device',
      manufacturer: 'Polar',
      connectionStatus: 'Available',
      icon: Icons.favorite,
    ),
  ];

  bool isScanning = false;
  bool isLoading = true;

  @override
  //load devices at page init
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading devices: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveConnectedDevices() async {
    try {
      await DeviceStorage.saveConnectedDevices(connectedDevices);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving devices: $e')));
    }
  }

  void scanForDevices() {
    setState(() {
      isScanning = true;
    });

    //Mock loading animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isScanning = true;
        });
      }
    });
  }

  void stopScanning() {
    setState(() {
      isScanning = false;
    });
  }

  void connectToDevice(Device device) {
    //Create the device according to the device model at models/device.dart
    final connectedDevice = Device(
      id: device.id,
      name: device.name,
      type: device.type,
      manufacturer: device.manufacturer,
      connectionStatus: 'Connected',
      icon: device.icon,
    );

    //Mock connection delay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Connecting to device...'),
              ],
            ),
          ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pop();

        setState(() {
          if (!connectedDevices.any((d) => d.id == device.id)) {
            connectedDevices.add(connectedDevice);
            _saveConnectedDevices();
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connected to ${device.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void disconnectDevice(Device device) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Disconnecting device...'),
              ],
            ),
          ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Navigator.of(context).pop();

        setState(() {
          connectedDevices.removeWhere((d) => d.id == device.id);
          _saveConnectedDevices();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Disconnected from ${device.name}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    });
  }

  void showDeviceDetails(Device device) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(device.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Device Type'),
                  subtitle: Text(device.type),
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Manufacturer'),
                  subtitle: Text(device.manufacturer),
                ),
                ListTile(
                  leading: const Icon(Icons.bluetooth_connected),
                  title: const Text('Status'),
                  subtitle: Text(device.connectionStatus),
                ),
                ListTile(
                  leading: const Icon(Icons.perm_device_info),
                  title: const Text('Device ID'),
                  subtitle: Text(device.id),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('View data functionality would go here'),
                    ),
                  );
                },
                child: const Text('View Data'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Manager'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connected Devices',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    ConnectedDevicesList(
                      connectedDevices: connectedDevices,
                      onDisconnect: disconnectDevice,
                      onTap: showDeviceDetails,
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add New Device',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        isScanning
                            ? Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: stopScanning,
                                  child: const Text('Stop'),
                                ),
                              ],
                            )
                            : ElevatedButton.icon(
                              onPressed: scanForDevices,
                              icon: const Icon(Icons.bluetooth_searching),
                              label: const Text('Scan'),
                            ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AvailableDevicesList(
                      isScanning: isScanning,
                      availableDevices: availableDevices,
                      connectedDevices: connectedDevices,
                      onConnect: connectToDevice,
                    ),
                  ],
                ),
              ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../models/device.dart';
import 'package:flutter/material.dart';

class DeviceStorage {
  static const String _fileName = 'connected_devices.json';

  //get local path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //get local file
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  //save connected devices logic
  static Future<void> saveConnectedDevices(List<Device> devices) async {
    try {
      final file = await _localFile;

      final devicesJson =
          devices
              .map(
                (device) => {
                  'id': device.id,
                  'name': device.name,
                  'type': device.type,
                  'manufacturer': device.manufacturer,
                  'connectionStatus': device.connectionStatus,
                  'iconCodePoint': device.icon.codePoint,
                  'iconFontFamily': device.icon.fontFamily,
                },
              )
              .toList();

      await file.writeAsString(jsonEncode(devicesJson));
    } catch (e) {
      print('Error saving connected devices: $e');
    }
  }

  //load connected devices logic
  static Future<List<Device>> loadConnectedDevices() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> devicesJson = jsonDecode(contents);

      return devicesJson
          .map(
            (json) => Device(
              id: json['id'],
              name: json['name'],
              type: json['type'],
              manufacturer: json['manufacturer'],
              connectionStatus: json['connectionStatus'],
              icon: IconData(
                json['iconCodePoint'],
                fontFamily: json['iconFontFamily'],
              ),
            ),
          )
          .toList();
    } catch (e) {
      print('Error loading connected devices: $e');
      return [];
    }
  }
}

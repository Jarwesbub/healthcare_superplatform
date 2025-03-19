import 'package:flutter/material.dart';

class Device {
  final String id;
  final String name;
  final String type;
  final String manufacturer;
  final String connectionStatus;
  final IconData icon;

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.manufacturer,
    required this.connectionStatus,
    required this.icon,
  });
}
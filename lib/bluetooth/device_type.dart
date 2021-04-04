import 'package:flutter_blue/flutter_blue.dart';

extension DeviceType on BluetoothDeviceType {
  String get rawValue {
    switch (this.index) {
      case 0:
        return "Unknown";
      case 1:
        return "Classic";
      case 2:
        return "Le(Low Energy)";
      case 3:
        return "Dual";
      default:
        return "Unknown";
    }
  }
}

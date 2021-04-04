import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobx/mobx.dart';
part 'bluetooth_view_model.g.dart';

class BluetoothViewModel = _BluetoothViewModelBase with _$BluetoothViewModel;

abstract class _BluetoothViewModelBase with Store {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @observable
  ObservableList<BluetoothDevice> devices =
      ObservableList<BluetoothDevice>.of([]);

  @action
  void _addDeviceTolist(final BluetoothDevice device) {
    if (!devices.contains(device)) {
      devices.add(device);
    }
  }

  @action
  Future<void> findDevices() async {
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan(timeout: Duration(seconds: 10));
  }
}

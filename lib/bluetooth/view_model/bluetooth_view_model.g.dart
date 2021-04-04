// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BluetoothViewModel on _BluetoothViewModelBase, Store {
  final _$devicesAtom = Atom(name: '_BluetoothViewModelBase.devices');

  @override
  ObservableList<BluetoothDevice> get devices {
    _$devicesAtom.reportRead();
    return super.devices;
  }

  @override
  set devices(ObservableList<BluetoothDevice> value) {
    _$devicesAtom.reportWrite(value, super.devices, () {
      super.devices = value;
    });
  }

  final _$findDevicesAsyncAction =
      AsyncAction('_BluetoothViewModelBase.findDevices');

  @override
  Future<void> findDevices() {
    return _$findDevicesAsyncAction.run(() => super.findDevices());
  }

  final _$_BluetoothViewModelBaseActionController =
      ActionController(name: '_BluetoothViewModelBase');

  @override
  void _addDeviceTolist(BluetoothDevice device) {
    final _$actionInfo = _$_BluetoothViewModelBaseActionController.startAction(
        name: '_BluetoothViewModelBase._addDeviceTolist');
    try {
      return super._addDeviceTolist(device);
    } finally {
      _$_BluetoothViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
devices: ${devices}
    ''';
  }
}

import 'package:blue/bluetooth/view/device_detail.dart';
import 'package:blue/bluetooth/view_model/bluetooth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../device_type.dart';

class DeviceList extends StatefulWidget {
  DeviceList({Key? key}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  final BluetoothViewModel bluetoothViewModel = BluetoothViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Device List')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildFindButton(),
                  buildBuildDevicesFoundText(context),
                ],
              ),
              buildDeviceListView(),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<BluetoothState> buildDeviceListView() {
    return StreamBuilder<BluetoothState>(
        stream: bluetoothViewModel.flutterBlue.state,
        builder: (context, snapshot) {
          final bluetoothState = snapshot.data;
          if (bluetoothState == BluetoothState.on) {
            return Observer(builder: (_) {
              return Flexible(
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: bluetoothViewModel.devices.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      var device = bluetoothViewModel.devices[index];
                      return ListTile(
                        title: Text(
                          device.id.toString(),
                        ),
                        subtitle: Text(device.name),
                        leading: Icon(Icons.bluetooth),
                        trailing: Text(device.type.rawValue),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeviceDetail(selectedDevice: device)));
                        },
                      );
                    }),
              );
            });
          } else
            return Center(
                child: Text('Your device\'s bluetooth is not available'));
        });
  }

  Padding buildBuildDevicesFoundText(BuildContext context) =>
      buildDevicesFoundText(context);

  Padding buildDevicesFoundText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Observer(builder: (_) {
        return Text(
            '${bluetoothViewModel.devices.length.toString()} device(s) found',
            style: Theme.of(context).textTheme.headline6);
      }),
    );
  }

  Widget _buildFindButton() {
    return StreamBuilder<bool>(
      builder: (context, snapshot) {
        if (snapshot.data == false) {
          return ElevatedButton(
              onPressed: () => bluetoothViewModel.findDevices(),
              child: ListTile(
                title: Text('Find device(s)'),
                leading: Icon(Icons.bluetooth),
              ));
        } else if (snapshot.data == true)
          return CircularProgressIndicator();
        else
          return Container();
      },
      stream: bluetoothViewModel.flutterBlue.isScanning,
    );
  }

  @override
  void initState() {
    super.initState();
    bluetoothViewModel.findDevices();
  }
}

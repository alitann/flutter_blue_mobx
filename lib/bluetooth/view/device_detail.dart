import 'package:blue/bluetooth/device_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceDetail extends StatelessWidget {
  const DeviceDetail({Key? key, required this.selectedDevice})
      : super(key: key);

  final BluetoothDevice selectedDevice;

  connectToDevice() async {
    await selectedDevice.connect(timeout: Duration(seconds: 10));
    await discoverServices();
  }

  discoverServices() async {
    List<BluetoothService> services = await selectedDevice.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        //do something
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            children: [buildDeviceCard()],
          ),
        ),
      ),
    );
  }

  Card buildDeviceCard() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Name"),
            subtitle: Text(selectedDevice.name),
          ),
          Divider(),
          ListTile(
            title: Text("Address"),
            subtitle: Text(selectedDevice.id.toString()),
          ),
          Divider(),
          ListTile(
            title: Text('Type'),
            subtitle: Text(selectedDevice.type.rawValue),
          ),
          Divider(),
          StreamBuilder<BluetoothDeviceState>(
            stream: selectedDevice.state,
            builder: (context, snapshot) {
              if (snapshot.data == BluetoothDeviceState.connected) {
                return ListTile(
                  title: Text('Status'),
                  subtitle: Text('Connected'),
                );
              } else {
                return ElevatedButton(
                    onPressed: () => connectToDevice(), child: Text('Connect'));
              }
            },
          ),
        ],
      ),
    );
  }
}

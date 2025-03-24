import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';

class DeviceStatusController extends GetxController {
  Rxn<Position> currentLocation = Rxn<Position>();
  late bool servicePermission = false;
  late LocationPermission permission;
  final info = NetworkInfo();
  var infoObject = {};
  // var infoObject = {};
  // var locationInfo = {};


  Future<void> getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        return;
      }
    }

    // Get and store current position
    Position position = await Geolocator.getCurrentPosition();

    currentLocation.value = position;

    print(
        "Latitude: ${currentLocation.value?.latitude}, Longitude: ${currentLocation.value?.longitude}");

    infoObject['latitude'] = currentLocation.value?.latitude.toString();
    infoObject['longitude'] = currentLocation.value?.longitude.toString();
  }

  Future<void> getNetworkInfo() async {
    String? wifiName = await info.getWifiName(); // "FooNetwork"

    print(wifiName);
    final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    print("ssid: $wifiBSSID");
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
    print('ip: $wifiIP');
    final wifiIPv6 =
        await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    print('iPv: $wifiIPv6');
    final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    print('Submask: $wifiSubmask');
    final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    print('brodcast: $wifiBroadcast');
    final wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1
    print('gateway: $wifiGateway');

    infoObject['wifi_name'] = wifiName.toString();
    infoObject['wifi_IP'] = wifiIP.toString();
    infoObject['wifi_iPv'] = wifiIPv6.toString();
    infoObject['wifi_submask'] = wifiSubmask.toString();
    infoObject['wifi_brodcast'] = wifiBroadcast.toString();
    infoObject['wifi_gateway'] = wifiGateway.toString();
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInformation = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInformation.androidInfo;
    print('Running on ${androidInfo.model}');

    infoObject['device_id'] = androidInfo.id.toString();
    infoObject['device_manufacturer'] = androidInfo.manufacturer.toString();
    infoObject['device_serialNumber'] = androidInfo.serialNumber.toString();
    infoObject['device_model'] = androidInfo.model.toString();
    infoObject['device_brand'] = androidInfo.brand.toString();
    infoObject['device_version'] = androidInfo.version.toString();
    infoObject['device_fingerprint'] = androidInfo.fingerprint.toString();
    infoObject['device_supportedAbis'] = androidInfo.supportedAbis.toString();
    infoObject['device_version'] = androidInfo.version.toString();
  }
}

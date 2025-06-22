import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class UserAgentHelper {
  static Future<String> initUserAgentState() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String buildNumber = packageInfo.buildNumber;
      String locale = Platform.localeName;
      String appName = packageInfo.appName;
      String systemName = '-';
      String deviceModel = '-';
      String manufacturer = '-';

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        systemName = 'Android ${androidInfo.version.release}'; // Contoh: Android 11
        deviceModel = androidInfo.model; // Contoh: SM-G975F
        manufacturer = androidInfo.manufacturer; // Contoh: Samsung
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        systemName = 'iOS ${iosInfo.systemVersion}'; // Contoh: iOS 15.3
        deviceModel = iosInfo.utsname.machine; // Contoh: iPhone13,4
        manufacturer = 'Apple';
      }

      String networkType = 'Unknown';
      List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();

      if (connectivityResults.contains(ConnectivityResult.wifi)) {
        networkType = 'WiFi';
      } else if (connectivityResults.contains(ConnectivityResult.mobile)) {
        networkType = 'Mobile';
      } else if (connectivityResults.contains(ConnectivityResult.none)) {
        networkType = 'None';
      }

      String ipAddress = await _getIpAddress();
      String macAddress = await _getMacAddress();

      String userAgent =
          '$appName/$appVersion (System/$systemName; Model/$deviceModel; Build/$buildNumber; Device-locale/$locale; Network/$networkType; IP/$ipAddress; MAC/$macAddress; Manufacturer/$manufacturer)';
      return userAgent;
    } catch (error) {
      return 'Digisatlink/<$error>';
    }
  }

  static Future<String> _getIpAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4) {
            return address.address;
          }
        }
      }
      return 'Unknown';
    } catch (error) {
      return 'Unknown';
    }
  }

  static Future<String> _getMacAddress() async {
    try {
      final info = NetworkInfo();
      String? macAddress = await info.getWifiBSSID();
      return macAddress ?? 'Unknown';
    } catch (error) {
      return 'Unknown';
    }
  }
}

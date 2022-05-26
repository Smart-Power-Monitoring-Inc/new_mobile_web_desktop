import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool isConnected = false;
CustomNetworkInfo _networkInfo = CustomNetworkInfo("", "");

/// Accepted Network Name is smarthub
/// Copy and paste the BSSID here

class NetworkController with ChangeNotifier {
  get networkInfo {
    return _networkInfo;
  }

  Future<bool> checkWifiNetwork(BuildContext context) async {
    // Used to check if the device is connected to a wifi network
    // Returns true if connected to a wifi network
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "You need to be connected to a wifi network for this application to function correctly")));

    return connectivityResult == ConnectivityResult.wifi;
  }

  Future<bool> checkNetworkSSID(BuildContext context) async {
    try {
      // Get the network name and BSSID
      bool isConnectedToWifi = await checkWifiNetwork(context);
      if (isConnectedToWifi) {
        final info = NetworkInfo();
        String? ssid = await info.getWifiName();
        String? bssid = await info.getWifiBSSID();

        _networkInfo = CustomNetworkInfo(ssid, bssid);
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

class CustomNetworkInfo {
  String? ssid, bssid;
  CustomNetworkInfo(this.ssid, this.bssid);
}

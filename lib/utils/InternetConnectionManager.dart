

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionManager {

  Future<bool> checkConnection() async {
    bool isInternetConnected = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isInternetConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {

      isInternetConnected = true;
    } else {
      isInternetConnected = false;
    }
    return isInternetConnected;
  }

}
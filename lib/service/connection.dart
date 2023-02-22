import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:groupsie/shared/global.dart';

class Connection {
  static checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      Global.isConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Global.isConnected = true;
    } else {
      Global.isConnected = false;
    }
    log("wifi global: ${Global.isConnected}");
  }

  static bool isConnected() {
    return Global.isConnected;
  }

  // static connectionDetector(
  //     ConnectivityResult connectivityResult, context, page) {
  //   // Got a new connectivity status!

  //   HelperFunctions.nextScreenReplacement(
  //     context,
  //     page,
  //   );
  //   Global.isConnected = (connectivityResult == ConnectivityResult.wifi ||
  //       connectivityResult == ConnectivityResult.mobile);
  //   log("wifi detector: $Global.isConnected");
  // }

  // static setConnectionActivity(context, page) {
  //   return Connectivity().onConnectivityChanged.listen(
  //       (conn) =>  connectionDetector(conn, context, page));
  // }
}
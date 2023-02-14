import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/service/auth_service.dart';

class Global {
  static late final AuthService authService;
  static bool _isConnected = false;

  Global() {
    authService = AuthService();
  }

  static bool isConnected() {
    return _isConnected;
  }

  static connectionDetector(
      ConnectivityResult connectivityResult, context, page) {
    // Got a new connectivity status!

      HelperFunctions.nextScreenReplacement(
        context,
        page,
      );
      _isConnected = (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile);
            log("wifi detector: $_isConnected");

  }
}

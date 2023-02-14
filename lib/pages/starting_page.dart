import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/pages/home_page.dart';
import 'package:groupsie/pages/network_error_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "StartingPage";

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  late final LoginInfo info;
  bool _isSignedIn = false;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void getUserLoggedinStatus() async {
    await HelperFunctions.getUserLoggedInInfo().then((value) => {
          if (value != null)
            {
              setState(() {
                _isSignedIn = value.isLoggedIn;
              })
            },
          // HelperFunctions.nextScreenReplacement(
          //   context,
          //   _isConnected
          //       ? (_isSignedIn ? const HomePage() : const LoginPage())
          //       : const NetworkErrorPage(),
          // )
        });
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else {
      setState(() {
        _isConnected = false;
      });
    }
    log("wifi: $_isConnected");
    getUserLoggedinStatus();

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Constants.mainColor,
      ),
    ));
  }
}

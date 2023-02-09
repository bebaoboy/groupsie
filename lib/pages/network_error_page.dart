import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/pages/search_page.dart';
import 'package:groupsie/pages/starting_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';

class NetworkErrorPage extends StatefulWidget {
  const NetworkErrorPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "NetworkErrorPage";

  @override
  State<NetworkErrorPage> createState() => _NetworkErrorPageState();
}

class _NetworkErrorPageState extends State<NetworkErrorPage> {
  late final LoginInfo info;
  late final subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      // Got a new connectivity status!
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        HelperFunctions.nextScreenReplacement(context, const StartingPage());
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        HelperFunctions.nextScreenReplacement(context, const StartingPage());
      } else {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Center(
            child: Column(children: [
              const Text(Strings.networkError),
              ElevatedButton(
                  onPressed: () {
                    HelperFunctions.nextScreenReplacement(
                        context, const StartingPage());
                  },
                  child: const Text(Strings.retry))
            ]),
          ),
        ),
      ),
    );
  }
}

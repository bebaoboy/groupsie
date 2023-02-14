import 'package:flutter/material.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';

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
  //late final subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Global.isConnected() ? null : SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Constants.errorColor, width: 2)),
              child: const Text(Strings.networkError),
            ),
            const SizedBox(height: 300,)
          ]),
        ),
      ),
    );
  }
}

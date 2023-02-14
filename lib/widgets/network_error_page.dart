import 'package:flutter/material.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/service/connection.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/strings.dart';

class NetworkErrorPage extends StatefulWidget {
  const NetworkErrorPage({super.key});
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700.0,
      height: Connection.isConnected() ? 0 : 100.0,
      child: Scaffold(
        body: Connection.isConnected()
            ? null
            : SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Constants.errorColor, width: 2)),
                      child: const Text(Strings.networkError),
                    ),
                    const SizedBox(
                      height: 300,
                    )
                  ]),
                ),
              ),
      ),
    );
  }
}

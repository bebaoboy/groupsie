import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/home_page_helper.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/pages/group_page.dart';
import 'package:groupsie/pages/loading_page.dart';
import 'package:groupsie/widgets/home_page_drawer.dart';
import 'package:groupsie/widgets/network_error_page.dart';
import 'package:groupsie/pages/search_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSignedIn = false;
  late final subscription;
  // Stream? groups;

  @override
  void initState() {
    super.initState();
    Global.isLoading = true;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((conn) => connectionDetector(conn));
    getUserLoggedinStatus();
  }

  connectionDetector(ConnectivityResult connectivityResult) {
    // Got a new connectivity status!

    if (!Global.isLoading) {
      HelperFunctions.nextScreenReplacement(
        context,
        const HomePage(),
      );
      log("Refreshing");
    }
    Global.isConnected = (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
    log("wifi detector: $Global.isConnected");
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void getUserLoggedinStatus() async {
    log(Global.isLoading.toString());
    await HelperFunctions.getUserLoggedInInfo().then((value) => {
          if (value != null)
            {
              setState(() {
                _isSignedIn = value.isLoggedIn;
                if (!_isSignedIn) {
                  HelperFunctions.nextScreenReplacement(
                    context,
                    const LoginPage(),
                  );
                } else {}
              })
            },
          getUserInfo()
        });
  }

  getUserInfo() async {
    await HelperFunctions.getUserLoggedInInfo().then((value) async {
      if (value != null) {
        Global.info = value;
        if (_isSignedIn) {
          // getting group list
          await getUserGroup().then((snapshot) {
            setState(() {
              Global.info.group = snapshot;
            });
          });
          Global.isLoading = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return !Global.isLoading
        ? Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () => {
                          HelperFunctions.nextScreen(
                              context, const SearchPage())
                        },
                    icon: searchIcon)
              ],
              centerTitle: true,
              backgroundColor: Constants.mainColor,
              title: const Text(Strings.groups, style: appBarStyle),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                child: Column(children: <Widget>[
                  Center(child: const NetworkErrorPage()),
                  // const Text(Strings.homepage),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Global.logOut(context);
                  //     },
                  //     child: const Text(Strings.logout))
                  getGroupList(Global.info.group, context),
                ]),
              ),
            ),
            drawer: const HomePageDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          Strings.createGroup,
                          textAlign: TextAlign.center,
                          style: headerStyle,
                        ),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextField(
                            onChanged: (value) =>
                                Global.newGroup.onGroupNameChange(value),
                            decoration: inputDecoration,
                          ),
                        ]),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                if (Global.newGroup.isEmptyGroupName()) {
                                } else {
                                  setState(() {
                                    Global.isLoading = true;
                                  });
                                  createGroup(
                                          username: Global.info.username,
                                          group: Global.newGroup)
                                      .then((value) {
                                    setState(() {
                                      Global.isLoading = false;
                                      Global.newGroup.reset();
                                      HelperFunctions.lastScreen(context);

                                      if (value != null) {
                                        HelperFunctions.showSnackBar(context,
                                            Constants.errorColor, value);
                                      } else {
                                        HelperFunctions.showSnackBar(
                                            context,
                                            Constants.doneColor,
                                            Strings.groupCreatedDone);
                                      }
                                    });
                                  });
                                }
                              },
                              child: const Text(Strings.continueTxt))
                        ],
                        actionsAlignment: MainAxisAlignment.center,
                      );
                    });
              },
              backgroundColor: Constants.mainColor,
              child: addIcon,
            ),
          )
        : const LoadingPage();
  }
}

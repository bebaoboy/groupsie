import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/profile_page.dart';
import 'package:groupsie/pages/search_page.dart';
import 'package:groupsie/pages/starting_page.dart';
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
  var info = LoginInfo();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    await HelperFunctions.getUserLoggedInInfo().then((value) {
      if (value != null) {
        info = value;
      }
      setState(() {});
    });
  }

  logOut() {
    Global.authService.signOut();
    HelperFunctions.nextScreenReplacement(context, const StartingPage());
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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  {HelperFunctions.nextScreen(context, const SearchPage())},
              icon: searchIcon)
        ],
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: const Text(Strings.groups, style: appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Center(
            child: Column(children: [
              const Text(Strings.homepage),
              ElevatedButton(
                  onPressed: () {
                    logOut();
                  },
                  child: const Text(Strings.logout))
            ]),
          ),
        ),
      ),
      drawer: SizedBox(
        width: drawerWidth,
        child: Drawer(
            child: ListView(
          padding: const EdgeInsets.symmetric(vertical: vPaddingGroupList),
          children: <Widget>[
            accountIcon,
            Text(
              info.username,
              textAlign: TextAlign.center,
              style: accountNameStyle,
            ),
            const SizedBox(
              height: boxSize * 3,
            ),
            const Divider(
              thickness: divThickness,
            ),
            ListTile(
              onTap: () {},
              selectedColor: Constants.mainColor,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: hPaddingTile, vertical: vPaddingTile),
              leading: groupIcon,
              title: const Text(
                Strings.groups,
                style: tileTextStyle,
              ),
            ),
            ListTile(
              onTap: () {
                HelperFunctions.nextScreen(context, const ProfilePage());
              },
              selectedColor: Constants.mainColor,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: hPaddingTile, vertical: vPaddingTile),
              leading: profileIcon,
              title: const Text(
                Strings.profile,
                style: tileTextStyle,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          Strings.logOutPromptTitle,
                          style: headerStyle,
                        ),
                        content: const Text(Strings.logOutPrompt),
                        actions: [
                          IconButton(
                              onPressed: () {
                                logOut();
                              },
                              icon: continueIcon),
                          IconButton(
                              onPressed: () {
                                HelperFunctions.lastScreen(context);
                              },
                              icon: cancelIcon)
                        ],
                      );
                    });
              },
              selectedColor: Constants.mainColor,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: hPaddingTile, vertical: vPaddingTile),
              leading: logoutIcon,
              title: const Text(
                Strings.logout,
                style: tileTextStyle,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/pages/profile_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({super.key});
  final String title = "HomePageDrawer";

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  //late final subscription;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUserInfo() async {
    await HelperFunctions.getUserLoggedInInfo().then((value) {
      if (value != null) {
        Global.info = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: vPaddingGroupList),
          children: <Widget>[
            accountIcon,
            Text(
              Global.info.username,
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
                                Global.logOut(context);
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
        ),
      ),
    );
  }

  logOut() {
    Global.authService.signOut();
    HelperFunctions.nextScreenReplacement(context, const LoginPage());
  }
}

import 'package:flutter/material.dart';
import 'package:groupsie/helper/group_helper.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';

class GroupProfilePage extends StatefulWidget {
  const GroupProfilePage({super.key, required this.group});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final Group group;

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "GroupProfilePage";

  @override
  State<GroupProfilePage> createState() => _GroupProfilePageState();
}

class _GroupProfilePageState extends State<GroupProfilePage> {
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
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: const Text(Strings.profile, style: appBarStyle),
      ),
      body: Center(
        child: SizedBox(
          width: HelperFunctions.getScreenSize(context).width,
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: vPaddingGroupList * 1.5, horizontal: hPadding),
              children: <Widget>[
                CircleAvatar(
                  radius: accountIconRadius / 2,
                  backgroundColor: Constants.mainColor,
                  child: CircleAvatar(
                      radius: accountIconRadius / 2 - 2,
                      backgroundColor: Colors.white,
                      child: Text(
                        widget.group.name.substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: titleFadedStyle,
                      )),
                ),
                const SizedBox(
                  height: boxSize * 3,
                ),
                ListTile(
                  onTap: () {},
                  selectedColor: Constants.mainColor,
                  selected: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: hPaddingTile, vertical: vPaddingTile),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          Strings.groupName,
                          textAlign: TextAlign.start,
                          style: tileTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            widget.group.name,
                            textAlign: TextAlign.end,
                            style: tileTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  selectedColor: Constants.mainColor,
                  selected: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: hPaddingTile, vertical: vPaddingTile),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text(
                          Strings.groupID,
                          textAlign: TextAlign.start,
                          style: tileTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            widget.group.id,
                            textAlign: TextAlign.end,
                            style: tileTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  selectedColor: Constants.mainColor,
                  selected: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: hPaddingTile, vertical: vPaddingTile),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text(
                          Strings.dateCreated,
                          textAlign: TextAlign.start,
                          style: tileTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            widget.group.dateCreated.toString(),
                            textAlign: TextAlign.end,
                            style: tileTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              Strings.leaveGroup,
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
                    Strings.leaveGroup,
                    style: tileTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

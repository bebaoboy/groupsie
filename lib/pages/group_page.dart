import 'package:flutter/material.dart';
import 'package:groupsie/helper/group_helper.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/chat_page.dart';
import 'package:groupsie/service/database_service.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/style/params.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key, required this.group});

  final Group group;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "GroupPage";

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late final LoginInfo info;

  @override
  void initState() {
    super.initState();
    getGroupInfo();
  }

  getGroupInfo() async {
    final result = await DatabaseService.getGroupData(widget.group.name);
    if (result.docs.length != 0) {
      widget.group.dateCreated = result.docs[0]['dateCreated'].toDate();
      widget.group.admins = List<String>.from(result.docs[0]['admins']);
      widget.group.members = List<String>.from(result.docs[0]['members']);
      // widget.group.snapshot = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // return SizedBox(
    //   width: 400,
    //   height: 200,
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
    //       child: Text(widget.groupName),
    //     ),
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        HelperFunctions.nextScreen(
            context,
            ChatPage(
              group: widget.group,
            ));
      },
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ListTile(
          title: Text(
            widget.group.name,
            style: accountNameStyle,
          ),
          subtitle: Text(widget.group.id),
          splashColor: Constants.secondaryColor,
          leading: CircleAvatar(
            radius: groupIconRadius,
            backgroundColor: Constants.mainColor,
            child: CircleAvatar(
                radius: groupIconRadius - 1,
                backgroundColor: Colors.white,
                child: Text(
                  widget.group.name.substring(0, 1).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: fadedStyle,
                )),
          ),
        ),
      ),
    );
  }
}

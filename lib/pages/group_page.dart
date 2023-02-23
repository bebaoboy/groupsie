import 'package:flutter/material.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/style/params.dart';

class GroupPage extends StatefulWidget {
  const GroupPage(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.username});

  final String groupName;
  final String groupId;
  final String username;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          widget.groupName,
          style: accountNameStyle,
        ),
        subtitle: Text(widget.groupId),
      ),
    );
  }
}

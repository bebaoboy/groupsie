import 'package:flutter/material.dart';
import 'package:groupsie/helper/chat_helper.dart';
import 'package:groupsie/helper/group_helper.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/group_profile_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/style/params.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.group});

  final Group group;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final LoginInfo info;

  @override
  void initState() {
    super.initState();
    getChatList();
  }

  getChatList() async {
    await getChats(widget.group.id).then((value) {
      //widget.group.messages = List<String>.from(value);
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                HelperFunctions.nextScreen(
                    context, GroupProfilePage(group: widget.group));
              },
              icon: infoIcon)
        ],
        backgroundColor: Constants.mainColor,
        title: Text(widget.group.name, style: appBarStyle),
        toolbarHeight: kToolbarHeight + 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(children: [
              //Text("${Strings.startChatting}\nThere is: ${widget.group.messages!.length}messages in here"),
              // ElevatedButton(
              //     onPressed: () {
              //       HelperFunctions.nextScreenReplacement(
              //           context, const HomePage());
              //     },
              //     child: const Text(Strings.retry))
            ]),
          ),
        ),
      ),
    );
  }
}

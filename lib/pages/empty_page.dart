import 'package:flutter/material.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "EmptyPage";

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
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
    return SingleChildScrollView(
      child: Center(
          child: Column(children: const [
            Text(
              Strings.empty,
              style: titleFadedStyle,
            ),
            
          ]),
        ),
    );
  }
}

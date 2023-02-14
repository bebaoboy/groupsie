import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupsie/pages/home_page.dart';
import 'package:groupsie/pages/starting_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';

import 'shared/Strings.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // run init for web

    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    // run init for android, ios
    await Firebase.initializeApp();
  }

  await splashScreenDelay(null, Constants.splashScreenDuration);

  runApp(const MyApp());
}

Future splashScreenDelay(BuildContext? context, duration) async {
  await Future.delayed(Duration(seconds: duration));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Global();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

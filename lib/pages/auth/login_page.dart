import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/shared/Strings.dart';
import 'package:groupsie/style/login_page_params.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: bgColor,
      // ),
      // body: Center(child: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Strings.appName,
                  style: titleStyle,
                ),
                const SizedBox(
                  height: titleBoxSize,
                ),
                Text(
                  Strings.appPrompt,
                  style: promptStyle,
                ),
                kIsWeb ? Image.asset(Strings.loginPageImg, width: 400,) : Image.asset(Strings.loginPageImg),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: "Email",
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

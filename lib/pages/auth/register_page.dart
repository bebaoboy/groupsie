import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/login_page_params.dart';
import 'package:groupsie/helper/login_page_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  final String title = "Register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  final info = LoginInfo();
  late FocusNode emailFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        emailKey.currentState!.validate();
      }
    });
  }

  @override
  void dispose() {
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: bgColor,
      // ),
      // body: Center(child: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: hPadding, vertical: vPadding * 2),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  Strings.registerText,
                  style: titleStyle,
                ),
                const SizedBox(
                  height: titleBoxSize * 5,
                ),
                // const Text(
                //   Strings.registerText,
                //   style: promptStyle,
                // ),
                TextFormField(
                  key: emailKey,
                  focusNode: emailFocus,
                  decoration: textInputDecoration.copyWith(
                    labelText: Strings.email,
                    prefixIcon: emailIcon,
                  ),
                  style: const TextStyle(fontSize: inputTextSize),
                  onChanged: (value) => info.onEmailChange(value),
                  validator: (value) => info.emailValidate(),
                ),
                const SizedBox(
                  height: titleBoxSize * 2,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: Strings.username,
                    prefixIcon: passwordIcon,
                  ),
                  style: const TextStyle(fontSize: inputTextSize),
                  onChanged: (value) => info.onPasswordChange(value),
                ),

                const SizedBox(
                  height: titleBoxSize * 2,
                ),
                TextFormField(
                  key: passwordKey,
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: Strings.password,
                    prefixIcon: passwordIcon,
                  ),
                  style: const TextStyle(fontSize: inputTextSize),
                  onChanged: (value) => info.onPasswordChange(value),
                ),
                const SizedBox(
                  height: titleBoxSize * 2,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: Strings.confirmPassword,
                    prefixIcon: passwordIcon,
                  ),
                  style: const TextStyle(fontSize: inputTextSize),
                  onChanged: (value) => info.onPasswordChange(value),
                ),
                const SizedBox(
                  height: titleBoxSize * 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.validate();
                        log("Email = ${info.email}, Pass = ${info.password}");
                      },
                      // style: loginButtonStyle,
                      child: const Text(
                        Strings.registerText,
                        style: loginButtonTextStyle,
                      )),
                ),
                const SizedBox(
                  height: titleBoxSize,
                ),
                Text.rich(TextSpan(
                  text: "${Strings.loginPrompt} ",
                  children: <TextSpan>[
                    TextSpan(
                        text: Strings.loginActionText,
                        style: registerActionStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            HelperFunctions.lastScreen(context);
                          }),
                  ],
                  style: registerPromptStyle,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/pages/auth/register_page.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/login_page_params.dart';
import 'package:groupsie/helper/login_page_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = "Login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  LoginInfo info = LoginInfo();
  late FocusNode emailFocus;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        emailKey.currentState!.validate();
      }
    });
    checkLoginInfo();
  }

  checkLoginInfo() async {
    await HelperFunctions.getUserLoggedInInfo().then((value) {
      if (value != null) {
        info = value;
        setState(() {
          emailController.text = info.email;
        });
      }
      log(value.toString());
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
          padding: !kIsWeb
              ? const EdgeInsets.symmetric(
                  horizontal: hPadding, vertical: vPadding)
              : const EdgeInsets.symmetric(
                  horizontal: hPaddingWeb, vertical: vPadding),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  Strings.appName,
                  style: titleStyle,
                ),
                const SizedBox(
                  height: titleBoxSize,
                ),
                const Text(
                  Strings.appPrompt,
                  style: promptStyle,
                ),
                kIsWeb
                    ? Image.asset(
                        Strings.loginPageImg,
                        width: 400,
                      )
                    : Image.asset(Strings.loginPageImg),
                TextFormField(
                  key: emailKey,
                  focusNode: emailFocus,
                  controller: emailController,
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
                  key: passwordKey,
                  obscureText: true,
                  controller: passwordController,
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        // formKey.currentState!.validate();
                        log("Email = ${info.email}, Pass = ${info.password}");
                      },
                      // style: loginButtonStyle,
                      child: const Text(
                        Strings.signInText,
                        style: loginButtonTextStyle,
                      )),
                ),
                const SizedBox(
                  height: titleBoxSize,
                ),
                Text.rich(TextSpan(
                  text: "${Strings.registerPrompt} ",
                  children: <TextSpan>[
                    TextSpan(
                        text: Strings.registerActionText,
                        style: registerActionStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            HelperFunctions.nextScreen(
                                context, const RegisterPage());
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

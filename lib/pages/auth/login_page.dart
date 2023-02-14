import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/pages/auth/register_page.dart';
import 'package:groupsie/pages/home_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';
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
          Global.isLoading = false;
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
      body: !Global.isLoading
          ? SingleChildScrollView(
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
                        height: boxSize,
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
                        // validator: (value) => info.emailValidate(),
                      ),
                      const SizedBox(
                        height: boxSize * 2,
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
                        validator: (value) => info.passwordValidate(),
                      ),
                      const SizedBox(
                        height: boxSize * 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              log("Email = ${info.email}, Pass = ${info.password}");
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  Global.isLoading = true;
                                });
                                await Global.authService
                                    .login(
                                        email: info.email,
                                        password: info.password)
                                    .then((value) {
                                  if (value == "true") {
                                    // saving the shared preference state
                                    if (Global.authService
                                            .emailValidate(info.email) ==
                                        "email") {
                                      HelperFunctions.saveUserLoggedInInfo(
                                              isLoggedIn: true,
                                              username: info.username,
                                              email: info.email)
                                          .then((value) => HelperFunctions
                                              .nextScreenReplacement(
                                                  context, const HomePage()));
                                    } else {
                                      HelperFunctions.saveUserLoggedInInfo(
                                              isLoggedIn: true,
                                              username: info.email,
                                              email: info.email)
                                          .then((value) => HelperFunctions
                                              .nextScreenReplacement(
                                                  context, const HomePage()));
                                    }

                                    // HelperFunctions.nextScreenReplacement(
                                    //     context, const HomePage());
                                  } else {
                                    HelperFunctions.showSnackBar(
                                      context,
                                      Constants.errorColor,
                                      value,
                                    );
                                    setState(() {});
                                  }
                                });
                              }
                            },
                            // style: loginButtonStyle,
                            child: const Text(
                              Strings.signInText,
                              style: loginButtonTextStyle,
                            )),
                      ),
                      const SizedBox(
                        height: boxSize,
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
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Constants.mainColor,
              ),
            ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/shared/global.dart';
import 'package:groupsie/shared/strings.dart';
import 'package:groupsie/style/params.dart';
import 'package:groupsie/helper/register_page_helper.dart';

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

  final info = RegisterInfo();
  late FocusNode emailFocus, passwordFocus;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        emailKey.currentState!.validate();
      }
    });
    passwordFocus.addListener(() {
      if (!passwordFocus.hasFocus) {
        passwordKey.currentState!.validate();
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
      body: !_isLoading
          ? SingleChildScrollView(
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
                        height: boxSize * 5,
                      ),
                      // const Text(
                      //   Strings.registerText,
                      //   style: promptStyle,
                      // ),
                      TextFormField(
                        initialValue: info.email,
                        key: emailKey,
                        focusNode: emailFocus,
                        decoration: loginInputDecoration.copyWith(
                          labelText: Strings.email,
                          prefixIcon: emailIcon,
                        ),
                        style: const TextStyle(fontSize: inputTextSize),
                        onChanged: (value) => info.onEmailChange(value),
                        validator: (value) => info.emailValidate(),
                      ),
                      const SizedBox(
                        height: boxSize * 2,
                      ),
                      TextFormField(
                        initialValue: info.username,
                        decoration: loginInputDecoration.copyWith(
                          labelText: Strings.username,
                          prefixIcon: usernameIcon,
                        ),
                        style: const TextStyle(fontSize: inputTextSize),
                        onChanged: (value) => info.onUsernameChange(value),
                        validator: (value) => info.usernameValidate(),
                      ),

                      const SizedBox(
                        height: boxSize * 2,
                      ),
                      TextFormField(
                        key: passwordKey,
                        focusNode: passwordFocus,
                        obscureText: true,
                        decoration: loginInputDecoration.copyWith(
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
                      TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: loginInputDecoration.copyWith(
                          labelText: Strings.confirmPassword,
                          prefixIcon: passwordIcon,
                        ),
                        style: const TextStyle(fontSize: inputTextSize),
                        onChanged: (value) => info.onPasswordChange2(value),
                        validator: (value) => info.passwordConfirmValidate(),
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
                                  _isLoading = true;
                                });
                                await Global.authService
                                    .register(
                                        email: info.email,
                                        password: info.password,
                                        username: info.username)
                                    .then((value) {
                                  if (value == "true") {
                                    // saving the shared preference state
                                    HelperFunctions.saveUserLoggedInInfo(
                                        isLoggedIn: false,
                                        username: info.username,
                                        email: info.email);
                                    HelperFunctions.showSnackBarAndGoBack(
                                      context,
                                      Constants.doneColor,
                                      Strings.finishRegister,
                                      page: const LoginPage(),
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else {
                                    HelperFunctions.showSnackBar(
                                      context,
                                      Constants.errorColor,
                                      value,
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              }
                            },
                            // style: loginButtonStyle,
                            child: const Text(
                              Strings.registerText,
                              style: loginButtonTextStyle,
                            )),
                      ),
                      const SizedBox(
                        height: boxSize,
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
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Constants.mainColor,
              ),
            ),
    );
  }
}

import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/helper/home_page_helper.dart';
import 'package:groupsie/helper/login_page_helper.dart';
import 'package:groupsie/pages/auth/login_page.dart';
import 'package:groupsie/service/auth_service.dart';
import 'package:groupsie/service/connection.dart';

class Global {
  static late final AuthService authService;
  static bool isConnected = false;
  static bool isLoading = true;

  static var info = LoginInfo();
  static var newGroup = Group();

  Global() {
    authService = AuthService();
    Connection.checkConnection();
  }

  static logOut(context) {
    Global.authService.signOut();
    HelperFunctions.nextScreenReplacement(context, const LoginPage());
  }
}

import 'package:groupsie/service/auth_service.dart';

class Global {
  static late final AuthService authService;

  Global() {
    authService = AuthService();
  }
}

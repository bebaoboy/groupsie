
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupsie/service/database_service.dart';

Future getChats(String groupId) async {
  return await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      .getChat(groupId);
}
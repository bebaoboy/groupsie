import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupsie/shared/entities.dart';

class DatabaseService {
  final String? uid;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Entity.userCollectionName);
  static final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection(Entity.groupCollectionName);

  DatabaseService({required this.uid});

  // update user data
  Future updateUserData({required String username, String? email}) async {
    return await userCollection
        .doc(uid)
        .set(Entity.createUser(uid, username, email));
  }

  // getting user data
  static Future getUserData({String email = "", String username = ""}) async {
    QuerySnapshot snapshot;
    if (email.isNotEmpty) {
      snapshot = await userCollection.where("email", isEqualTo: email).get();
    } else {
      snapshot =
          await userCollection.where("username", isEqualTo: username).get();
    }

    return snapshot;
  }
}

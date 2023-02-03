import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupsie/shared/entities.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Entity.userCollectionName);
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection(Entity.groupCollectionName);

  DatabaseService({required this.uid});

  // update user data
  Future updateUserData({required String username, String? email}) async {
    return await userCollection.doc(uid).set(Entity.createUser(uid, username, email));
  }
}

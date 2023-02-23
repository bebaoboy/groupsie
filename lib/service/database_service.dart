import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupsie/shared/entities.dart';
import 'package:groupsie/shared/strings.dart';

class DatabaseService {
  final String? uid;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Entity.userCollectionName);
  static final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection(Entity.groupCollectionName);

  DatabaseService({required this.uid});

  // update user data
  Future createUserData({required String username, String? email}) async {
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

  static Future getGroupData(String groupName) async {
    QuerySnapshot snapshot;
    snapshot = await groupCollection.where("groupName", whereIn: [
      groupName.toLowerCase(),
      groupName,
      groupName.toUpperCase()
    ]).get();
    return snapshot;
  }

  // getting user group
  Future getUserGroup({String email = "", String username = ""}) async {
    log("current uid $uid");
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(
      {required String username,
      required String groupName,
      List? admins,
      List? members,
      icon = ""}) async {
    final result = await DatabaseService.getGroupData(groupName);
    if (result.docs.length != 0) {
      return Strings.groupExists;
    }
    var docReference = await groupCollection.add(Entity.createGroup(
        username, groupName,
        admins: admins, members: members, icon: icon));
    await docReference.update({
      "groupId": docReference.id,
    });
    await addMemberToGroup(docReference, username, admin: true);
    return await addGroupToUser(username, docReference.id, groupName);
  }

  Future addMemberToGroup(DocumentReference doc, username,
      {admin = false}) async {
    await doc.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
    });
    if (admin) {
      await doc.update({
        "admins": FieldValue.arrayUnion(["${uid}_$username"]),
      });
    }
  }

  Future addGroupToUser(username, groupId, groupName) async {
    return await userCollection.doc(uid).update({
      "groups": FieldValue.arrayUnion(["${groupId}_$groupName"]),
    });
  }
}

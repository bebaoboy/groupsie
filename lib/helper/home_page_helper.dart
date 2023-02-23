import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/pages/empty_group_page.dart';
import 'package:groupsie/pages/group_page.dart';
import 'package:groupsie/pages/loading_page.dart';
import 'package:groupsie/service/database_service.dart';

class Group {
  String name = "";
  List<String> members = List.empty();
  List<String> admins = List.empty();
  String icon = "";

  onGroupNameChange(name) {
    this.name = name;
  }

  isEmptyGroupName() {
    return name.isEmpty;
  }

  reset() {
    name = "";
    icon = "";
    members = List.empty();
    admins = List.empty();
  }
}

getGroupList(Stream? group, context) {
  return StreamBuilder(
      stream: group,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.data() != null &&
              snapshot.data.data()['groups'] != null &&
              snapshot.data.data()['groups'].length != 0) {
            //log(snapshot.data.data()['groups']);

            return const GroupPage();
          } else {
            return const EmptyGroupPage();
          }
        } else {
          return const SizedBox(width: 200, height: 600, child: LoadingPage());
        }
      });
}

Future getUserGroup() async {
  return await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      .getUserGroup();
}

Future createGroup({required String username, required Group group}) async {
  return await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      .createGroup(
          username: username,
          groupName: group.name,
          icon: group.icon,
          members: group.members,
          admins: group.admins);
}

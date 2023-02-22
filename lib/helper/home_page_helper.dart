import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/pages/empty_group_page.dart';
import 'package:groupsie/pages/group_page.dart';
import 'package:groupsie/pages/loading_page.dart';
import 'package:groupsie/service/database_service.dart';

createGroupDialog(BuildContext context) {}

getGroupList(Stream? group, context) {
  return StreamBuilder(
      stream: group,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          log(snapshot.data.data()['username']);
          if (snapshot.data.data()['groups'] != null &&
              snapshot.data.data()['groups'].length != 0) {
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

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/group_helper.dart';
import 'package:groupsie/pages/empty_group_page.dart';
import 'package:groupsie/pages/group_page.dart';
import 'package:groupsie/pages/loading_page.dart';
import 'package:groupsie/service/database_service.dart';
import 'package:groupsie/shared/global.dart';


getGroupList(Stream? group, context) {
  return StreamBuilder(
      stream: group,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.data() != null &&
              snapshot.data.data()['groups'] != null &&
              snapshot.data.data()['groups'].length != 0) {
            //log(snapshot.data.data()['groups']);
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.data()['groups'].length,
                itemBuilder: (context, index) {
                  return GroupPage(
                    group: Group(
                      id: getGroupId(
                        snapshot.data.data()['groups'][index]), 
                        name: getGroupName(snapshot.data.data()['groups'][index]),
                        ));
                });
          } else {
            return const EmptyGroupPage();
          }
        } else {
          return const SizedBox(width: 200, height: 600, child: LoadingPage());
        }
      });
}

String getGroupId(String res) {
  return res.substring(0, res.indexOf("_"));
}

String getGroupName(String res) {
  return res.substring(res.indexOf("_") + 1);
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

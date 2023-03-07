import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupsie/helper/group_helper.dart';
import 'package:groupsie/pages/empty_group_page.dart';
import 'package:groupsie/pages/group_page.dart';
import 'package:groupsie/pages/loading_page.dart';
import 'package:groupsie/service/database_service.dart';
import 'package:groupsie/shared/constants.dart';
import 'package:groupsie/style/params.dart';

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
                    id: getGroupId(snapshot.data.data()['groups'][index]),
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

groupAdminParser(List<String> s) {
  List<String> newS = [];
  for (var i in s) {
    newS.add(getAdminName(i));
  }
  return newS;
}

String getAdminName(s) {
  return s.split("_")[1];
}

getAdmins(List<String> admins, context, {text = "admin"}) {
  return StreamBuilder(
      stream: Stream.fromIterable(admins),
      builder: (context, snapshot) {
        //log(snapshot.data.data()['groups']);
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: admins.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: groupIconRadius * 0.8,
                      backgroundColor: Constants.mainColor,
                      child: Text(getAdminName(admins[index]).substring(0, 1)),
                    ),
                    title: Text(getAdminName(admins[index])),
                  ),
              );
            });
      });
}

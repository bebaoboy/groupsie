class Entity {
  static String userCollectionName = "Users";
  static createUser(uid, username, email, {groups, avatar}) {
    return {
      "username": username,
      "email": email,
      "groups": [],
      "avatar": "",
      "uid": uid,
    };
  }

  static String groupCollectionName = "Groups";
  static createGroup(username, groupName,
      {List? admins, List? members, icon = ""}) {
    return {
      "groupId": "",
      "groupName": groupName,
      "groupIcon": icon,
      "members": members,
      "admins": admins,
      "recentMessage": "",
      "recentMessageSender": "",
    };
  }
}

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
}

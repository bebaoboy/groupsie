class Group {
  String name = "";
  String id = "";
  List<String> members = List.empty();
  List<String> admins = List.empty();
  List<String>? messages = List.empty();
  String icon = "";
  DateTime dateCreated = DateTime.now();
  String recentMessage = "";
  DateTime recentMessageTime = DateTime.now();

  Group({this.name = "", this.id = "", this.messages});

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

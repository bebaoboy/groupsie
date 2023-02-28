class Group {
  String name = "";
  String id = "";
  List<String> members = List.empty();
  List<String> admins = List.empty();
  String icon = "";

  Group({this.name = "", this.id = ""});

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

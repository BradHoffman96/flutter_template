class User {
  String id;
  String email;
  String displayName;

  User.initial()
    : id = '',
      email = '',
      displayName = '';

  User({this.id, this.email, this.displayName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    displayName = json['display_name'];
  }
}
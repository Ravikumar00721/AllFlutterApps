class UserModel {
  String? uid;
  String? email;
  String? mobileno;
  String? name;

  UserModel({required this.uid, this.email, this.mobileno, this.name});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    email = map["email"];
    mobileno = map["mobileno"];
    name = map["name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "mobileno": mobileno,
      "name": name,
    };
  }
}

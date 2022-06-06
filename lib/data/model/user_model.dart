import 'dart:convert';

import 'package:my_game/domain/entity/user.dart';

class UserModel extends User {
  final String uid;

  UserModel(
      {required this.uid,
      required String firstName,
      required String lastName,
      required String email,
      required String username})
      : super(
            firstName: firstName,
            lastName: lastName,
            email: email,
            username: username);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        username: map['username']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username
      };

  String toJson() => jsonEncode(toMap());

  static User? toDomain(UserModel? userModel) {
    if(userModel != null) {
      return User(
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        email: userModel.email,
        username: userModel.username,
      );
    }
    return null;
  }
}

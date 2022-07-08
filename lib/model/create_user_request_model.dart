import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreateUserRequestModel {
  String name;
  String email;
  String password;
  String passwordConfirm;
  CreateUserRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
    };
  }

  factory CreateUserRequestModel.fromMap(Map<String, dynamic> map) {
    return CreateUserRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirm: map['passwordConfirm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUserRequestModel.fromJson(String source) =>
      CreateUserRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

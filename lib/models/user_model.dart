import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum UserRole {
  parent,
  shoolAdmin,
  superAdmin;
}

UserRole _stringToEnum(String input) {
  switch (input) {
    case 'parent':
      return UserRole.parent;
    case 'shoolAdmin':
      return UserRole.shoolAdmin;
    case 'superAdmin':
      return UserRole.superAdmin;
    default:
      return UserRole.parent;
  }
}

class UserModel {
  final String id;
  final String name;
  final String contact;
  final String email;
  final UserRole userRole;
  UserModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.userRole,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? contact,
    String? email,
    UserRole? userRole,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'userRole': userRole.name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      contact: map['contact'].toString(),
      email: map['email'].toString(),
      userRole: _stringToEnum(map['userRole'] ?? 'parent'),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

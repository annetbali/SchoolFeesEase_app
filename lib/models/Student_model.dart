import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudentModel {
  final String id;
  final String name;
  final String address;
  final String level;
  StudentModel({
    required this.id,
    required this.name,
    required this.address,
    required this.level, 
  });

  StudentModel copyWith({
    String? id,
    String? name,
    String? address,
    String? level,
    String? studentNumber
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'level': level,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      level: map['level'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SchoolModel {
  final String id;
  final String name;
  final String address;
  final String bankName;
  final String accountNumber;
  SchoolModel({
    required this.id,
    required this.name,
    required this.address,
    required this.bankName,
    required this.accountNumber,
  });

  SchoolModel copyWith({
    String? id,
    String? name,
    String? address,
    String? bankName,
    String? accountNumber,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'bankName': bankName,
      'accountNumber': accountNumber,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      bankName: map['bankName'] as String,
      accountNumber: map['accountNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolModel.fromJson(String source) => SchoolModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

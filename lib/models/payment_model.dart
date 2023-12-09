// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:school_fees_ease/models/Student_model.dart';
import 'package:school_fees_ease/models/school_model.dart';

class PaymentModel {
  final String id;
  final String amount;
  final String? purpose;
  final String paymentMethod;
  final String paymentProvider;
  final SchoolModel school;
  final StudentModel student;
  final DateTime createdAt;
  final DateTime updatedAt;
  PaymentModel({
    required this.id,
    required this.amount,
    this.purpose,
    required this.paymentMethod,
    required this.paymentProvider,
    required this.school,
    required this.student,
    required this.createdAt,
    required this.updatedAt,
  });

  PaymentModel copyWith({
    String? id,
    String? amount,
    String? purpose,
    String? paymentMethod,
    String? paymentProvider,
    SchoolModel? school,
    StudentModel? student,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      purpose: purpose ?? this.purpose,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentProvider: paymentProvider ?? this.paymentProvider,
      school: school ?? this.school,
      student: student ?? this.student,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'purpose': purpose,
      'paymentMethod': paymentMethod,
      'paymentProvider': paymentProvider,
      'school': school.toMap(),
      'student': student.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as String,
      amount: map['amount'] as String,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      paymentMethod: map['paymentMethod'] as String,
      paymentProvider: map['paymentProvider'] as String,
      school: SchoolModel.fromMap(map['school'] as Map<String,dynamic>),
      student: StudentModel.fromMap(map['student'] as Map<String,dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) => PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

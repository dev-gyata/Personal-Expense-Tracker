import 'dart:convert';

import 'package:equatable/equatable.dart';

class IncomeResponseDto extends Equatable {
  const IncomeResponseDto({
    required this.id,
    required this.nameOfRevenue,
    required this.amount,
  });

  factory IncomeResponseDto.fromMap(Map<String, dynamic> map) {
    return IncomeResponseDto(
      id: (map['id'] ?? '') as String,
      nameOfRevenue: (map['nameOfRevenue'] ?? '') as String,
      amount: (map['amount'] ?? 0.0) as double,
    );
  }

  factory IncomeResponseDto.fromJson(String source) =>
      IncomeResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
  final String id;
  final String nameOfRevenue;
  final double amount;

  IncomeResponseDto copyWith({
    String? id,
    String? nameOfRevenue,
    double? amount,
  }) {
    return IncomeResponseDto(
      id: id ?? this.id,
      nameOfRevenue: nameOfRevenue ?? this.nameOfRevenue,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameOfRevenue': nameOfRevenue,
      'amount': amount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, nameOfRevenue, amount];
}

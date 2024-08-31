import 'dart:convert';

import 'package:equatable/equatable.dart';

class IncomeCreationRequestDto extends Equatable {
  const IncomeCreationRequestDto({
    required this.nameOfRevenue,
    required this.amount,
  });

  factory IncomeCreationRequestDto.fromMap(Map<String, dynamic> map) {
    return IncomeCreationRequestDto(
      nameOfRevenue: (map['nameOfRevenue'] ?? '') as String,
      amount: (map['amount'] ?? 0.0) as double,
    );
  }

  factory IncomeCreationRequestDto.fromJson(String source) =>
      IncomeCreationRequestDto.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  final String nameOfRevenue;
  final double amount;

  IncomeCreationRequestDto copyWith({
    String? nameOfRevenue,
    double? amount,
  }) {
    return IncomeCreationRequestDto(
      nameOfRevenue: nameOfRevenue ?? this.nameOfRevenue,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameOfRevenue': nameOfRevenue,
      'amount': amount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [nameOfRevenue, amount];
}

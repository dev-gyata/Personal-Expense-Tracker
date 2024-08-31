import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExpenditureCreationRequestDto extends Equatable {
  const ExpenditureCreationRequestDto({
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  factory ExpenditureCreationRequestDto.fromMap(Map<String, dynamic> map) {
    return ExpenditureCreationRequestDto(
      category: (map['category'] ?? '') as String,
      nameOfItem: (map['nameOfItem'] ?? '') as String,
      estimatedAmount: (map['estimatedAmount'] ?? 0.0) as double,
    );
  }

  factory ExpenditureCreationRequestDto.fromJson(String source) =>
      ExpenditureCreationRequestDto.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  final String category;
  final String nameOfItem;
  final double estimatedAmount;

  ExpenditureCreationRequestDto copyWith({
    String? category,
    String? nameOfItem,
    double? estimatedAmount,
  }) {
    return ExpenditureCreationRequestDto(
      category: category ?? this.category,
      nameOfItem: nameOfItem ?? this.nameOfItem,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'nameOfItem': nameOfItem,
      'estimatedAmount': estimatedAmount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [category, nameOfItem, estimatedAmount];
}

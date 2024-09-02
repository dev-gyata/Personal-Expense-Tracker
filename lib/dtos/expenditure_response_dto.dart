import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExpenditureResponseDto extends Equatable {
  const ExpenditureResponseDto({
    required this.id,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  factory ExpenditureResponseDto.fromMap(Map<String, dynamic> map) {
    return ExpenditureResponseDto(
      id: (map['id'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      nameOfItem: (map['nameOfItem'] ?? '') as String,
      estimatedAmount:
          double.tryParse(map['estimatedAmount']?.toString() ?? '0.0') ?? 0.0,
    );
  }

  factory ExpenditureResponseDto.fromJson(String source) =>
      ExpenditureResponseDto.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  final String id;
  final String category;
  final String nameOfItem;
  final double estimatedAmount;

  ExpenditureResponseDto copyWith({
    String? id,
    String? category,
    String? nameOfItem,
    double? estimatedAmount,
  }) {
    return ExpenditureResponseDto(
      id: id ?? this.id,
      category: category ?? this.category,
      nameOfItem: nameOfItem ?? this.nameOfItem,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'nameOfItem': nameOfItem,
      'estimatedAmount': estimatedAmount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, category, nameOfItem, estimatedAmount];
}

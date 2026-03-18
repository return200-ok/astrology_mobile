import 'package:flutter/material.dart';

class BirthProfile {
  final String name;
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final String gender;
  final int cuc;

  BirthProfile({
    required this.name,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
    required this.cuc,
  });

  BirthProfile copyWith({
    String? name,
    DateTime? birthDate,
    TimeOfDay? birthTime,
    String? gender,
    int? cuc,
  }) {
    return BirthProfile(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      gender: gender ?? this.gender,
      cuc: cuc ?? this.cuc,
    );
  }
}

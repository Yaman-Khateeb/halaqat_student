import 'package:flutter/material.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String fatherName;
  final DateTime? birthDate;
  final String? imageUrl;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.birthDate,
    this.imageUrl,
  );
factory User.fromJson(Map<String, dynamic> json) {
    print('The user id is  ${json['id']}');
  return User(
    json['id'], //it is already int, no need to int.parse it
    json['first_name'] ?? '',
    json['last_name'] ?? '',
    json['father_name'] ?? '',
    DateTime.tryParse(json['birth_date'] ?? ''),
    json['profile_picture'] ?? '',
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'first_name': firstName,
      'last_name': lastName,
      'father_name': fatherName,
      'birth_date': birthDate?.toIso8601String(),
      'profile_picture': imageUrl ?? '',
    };
  }

  ImageProvider get image {
    print('Image URL is $imageUrl');
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!);
    } else {
      return const AssetImage('assets/images/avatar.jpg');
    }
  }
}

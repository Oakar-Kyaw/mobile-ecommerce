class User {
  final int? id;
  final String? email;
  final String? photoUrl;
  final String? identification;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? phone;
  final String? gender;
  final String? role;
  final DateTime? dateOfBirth;

  User({
    this.id,
    this.email,
    this.photoUrl,
    this.identification,
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
    this.gender = "MALE",
    this.role = "CUSTOMER",
    this.dateOfBirth,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      identification: json['identification'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] ?? 'MALE',
      role: json['role'] ?? 'CUSTOMER',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'photoUrl': photoUrl,
      'identification': identification,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'gender': gender.toString().split('.').last,
      'role': role.toString().split('.').last,
    };
  }
}

// Example enums
// enum Gender { MALE, FEMALE, OTHER }
// enum Role { CUSTOMER, ADMIN, MANAGER }

// Example placeholder classes for relations
class BrandUserRelationship {
  BrandUserRelationship();

  factory BrandUserRelationship.fromJson(Map<String, dynamic> json) {
    return BrandUserRelationship();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class DeviceInfo {
  DeviceInfo();

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

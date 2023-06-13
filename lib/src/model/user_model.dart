import 'dart:convert';

import 'package:tfg_front/src/model/auth_role_enum.dart';

class UserModel {
  int? id;
  int? schoolId;
  int? classId;
  String? className; // Extra
  String? name;
  String? registration;
  DateTime? birthDate;
  AuthRoleEnum? role;
  String? phone;
  String? email;
  String? cpf;
  String? rg;
  String? password;
  String? profilePicture;
  // String? cep;
  String? address;
  // String? city;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? get birthString {
    if (birthDate == null) return null;
    return '${birthDate?.day.toString().padLeft(2, '0')}/${birthDate?.month.toString().padLeft(2, '0')}/${birthDate?.year.toString().padLeft(4, '0')}';
  }

  set birthString(String? value) {
    try {
      final date = value!.split('/');
      birthDate = DateTime(
        int.parse(date[2]),
        int.parse(date[1]),
        int.parse(date[0]),
      );
    } catch (_) {
      birthDate = null;
    }
  }

  bool get isEmpty => name == null;

  UserModel({
    this.id,
    this.schoolId,
    this.classId,
    this.className,
    this.name,
    this.registration,
    this.birthDate,
    this.role,
    this.phone,
    this.email,
    this.cpf,
    this.rg,
    this.password,
    this.profilePicture,
    // this.cep,
    this.address,
    // this.city,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    int? schoolId,
    String? className,
    int? classId,
    String? name,
    String? registration,
    DateTime? birthDate,
    AuthRoleEnum? role,
    String? phone,
    String? email,
    String? cpf,
    String? rg,
    String? password,
    String? profilePicture,
    String? cep,
    String? address,
    // String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      className: className ?? this.className,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      registration: registration ?? this.registration,
      birthDate: birthDate ?? this.birthDate,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      // cep: cep ?? this.cep,
      address: address ?? this.address,
      // city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'school_id': schoolId,
      'class_id': classId,
      'name': name,
      'registration': registration,
      'birth_date': birthDate?.toIso8601String(),
      'role': role?.name,
      'phone': phone,
      'email': email,
      'cpf': cpf,
      'rg': rg,
      'password': password,
      'profile_picture': profilePicture,
      // 'cep': cep,
      'address': address,
      // 'city': city,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      classId: map['classId'] != null ? map['classId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      registration: map['registration'] != null ? map['registration'] as String : null,
      birthDate: DateTime.tryParse(map['birth_date'] as String? ?? ''),
      role: AuthRoleEnum.fromName(map['role'] as String?),
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      rg: map['rg'] != null ? map['rg'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profilePicture: map['profile_picture'] != null ? map['profile_picture'] as String : null,
      // cep: map['cep'] != null ? map['cep'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      // city: map['city'] != null ? map['city'] as String : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, schoolId: $schoolId, classId: $classId, name: $name, registration: $registration, birthDate: $birthDate, role: $role, phone: $phone, email: $email, cpf: $cpf, rg: $rg, password: $password, profilePicture: $profilePicture, address: $address, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.schoolId == schoolId &&
        other.classId == classId &&
        other.name == name &&
        other.registration == registration &&
        other.birthDate == birthDate &&
        other.role == role &&
        other.phone == phone &&
        other.email == email &&
        other.cpf == cpf &&
        other.rg == rg &&
        other.password == password &&
        other.profilePicture == profilePicture &&
        // other.cep == cep &&
        other.address == address &&
        // other.city == city &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        schoolId.hashCode ^
        classId.hashCode ^
        name.hashCode ^
        registration.hashCode ^
        birthDate.hashCode ^
        role.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        cpf.hashCode ^
        rg.hashCode ^
        password.hashCode ^
        profilePicture.hashCode ^
        // cep.hashCode ^
        address.hashCode ^
        // city.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

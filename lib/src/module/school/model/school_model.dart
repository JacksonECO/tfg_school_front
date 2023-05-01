import 'dart:convert';
import 'dart:developer';

class SchoolModel {
  int? id;
  String name;
  String cnpj;
  String? logo;
  String? social;
  String cep;
  String phone;
  String email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  SchoolModel({
    this.id,
    required this.name,
    required this.cnpj,
    this.logo,
    this.social,
    required this.cep,
    required this.phone,
    required this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory SchoolModel.clean() {
    return SchoolModel(
      id: null,
      name: '',
      cnpj: '',
      logo: null,
      social: null,
      cep: '',
      phone: '',
      email: '',
      password: '',
      createdAt: null,
      updatedAt: null,
    );
  }

  SchoolModel copyWith({
    int? id,
    String? name,
    String? cnpj,
    String? logo,
    String? social,
    String? cep,
    String? phone,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
      logo: logo ?? this.logo,
      social: social ?? this.social,
      cep: cep ?? this.cep,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cnpj': cnpj,
      'logo': logo,
      'social': social,
      'cep': cep,
      'phone': phone,
      'email': email,
      'password': password,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    try {
      return SchoolModel(
        id: map['id'] as int,
        name: map['name'] as String,
        cnpj: map['cnpj'] as String,
        logo: map['logo'] as String?,
        social: map['social'] != null ? map['social'] as String : null,
        cep: map['cep'] as String,
        phone: map['phone'] as String,
        email: map['email'] as String,
        // password: map['password'] as String?,
        // createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
        // updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
      );
    } catch (e, s) {
      log('Error on SchoolModel.fromMap: ', error: e, stackTrace: s);
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory SchoolModel.fromJson(String source) =>
      SchoolModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchoolModel(id: $id, name: $name, cnpj: $cnpj, logo: $logo, social: $social, cep: $cep, phone: $phone, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SchoolModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.cnpj == cnpj &&
        other.logo == logo &&
        other.social == social &&
        other.cep == cep &&
        other.phone == phone &&
        other.email == email &&
        other.password == password &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        cnpj.hashCode ^
        logo.hashCode ^
        social.hashCode ^
        cep.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

/*
    id SERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    logo jsonb,
    social jsonb,
    cep VARCHAR(9) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
*/
import 'dart:convert';

class UserModel {
  int? id;
  int? schoolId;
  int? classId;
  String? name;
  String? registration;
  DateTime? birthDate;
  String? role;
  String? phone;
  String? email;
  String? cpf;
  String? rg;
  String? password;
  String? profilePicture;
  String? cep;
  String? address;
  String? city;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.schoolId,
    this.classId,
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
    this.cep,
    this.address,
    this.city,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    int? schoolId,
    int? classId,
    String? name,
    String? registration,
    DateTime? birthDate,
    String? role,
    String? phone,
    String? email,
    String? cpf,
    String? rg,
    String? password,
    String? profilePicture,
    String? cep,
    String? address,
    String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
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
      cep: cep ?? this.cep,
      address: address ?? this.address,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolId': schoolId,
      'classId': classId,
      'name': name,
      'registration': registration,
      // 'birthDate': birthDate?.millisecondsSinceEpoch,
      'role': role,
      'phone': phone,
      'email': email,
      'cpf': cpf,
      'rg': rg,
      'password': password,
      'profilePicture': profilePicture,
      'cep': cep,
      'address': address,
      'city': city,
      // 'createdAt': createdAt?.millisecondsSinceEpoch,
      // 'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      classId: map['classId'] != null ? map['classId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      registration: map['registration'] != null ? map['registration'] as String : null,
      // birthDate: map['birthDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int) : null,
      role: map['role'] != null ? map['role'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      rg: map['rg'] != null ? map['rg'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      // createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      // updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, schoolId: $schoolId, classId: $classId, name: $name, registration: $registration, birthDate: $birthDate, role: $role, phone: $phone, email: $email, cpf: $cpf, rg: $rg, password: $password, profilePicture: $profilePicture, cep: $cep, address: $address, city: $city, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
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
      other.cep == cep &&
      other.address == address &&
      other.city == city &&
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
      cep.hashCode ^
      address.hashCode ^
      city.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

class ClassModel {
  int? id;
  int? schoolId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  ClassModel({
    this.id,
    this.schoolId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  // ValidatorLess used on the form
  bool get isEmpty => name == null;

  ClassModel copyWith({
    int? id,
    int? schoolId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolId': schoolId,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? ''),
    );
  }

  @override
  String toString() {
    return 'ClassModel(id: $id, schoolId: $schoolId, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ClassModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.schoolId == schoolId &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        schoolId.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

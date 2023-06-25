import 'dart:convert';

import 'package:mobx/mobx.dart';
part 'user_attendance_model.g.dart';

class UserAttendanceModel extends _UserAttendanceModelBase with _$UserAttendanceModel {
  UserAttendanceModel({
    required super.userId,
    required super.userName,
    required super.userRegistration,
    super.isPresent = true,
  });

  factory UserAttendanceModel.fromMap(Map<String, dynamic> map) {
    return UserAttendanceModel(
      userId: map['userId'] as int,
      userName: map['userName'] as String,
      userRegistration: map['userRegistration'] as String,
      isPresent: map['isPresent'] as bool,
    );
  }

  factory UserAttendanceModel.fromJson(String source) =>
      UserAttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class _UserAttendanceModelBase with Store {
  @observable
  bool isPresent;

  int userId;
  String userName;
  String userRegistration;

  _UserAttendanceModelBase({
    required this.userId,
    required this.userName,
    required this.userRegistration,
    this.isPresent = false,
  });

  _UserAttendanceModelBase copyWith({
    int? userId,
    String? userName,
    String? userRegistration,
    bool? isPresent,
  }) {
    return UserAttendanceModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userRegistration: userRegistration ?? this.userRegistration,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userRegistration': userRegistration,
      'isPresent': isPresent,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '_UserAttendanceModelBase(userId: $userId, userName: $userName, userRegistration: $userRegistration, isPresent: $isPresent)';
  }

  @override
  bool operator ==(covariant _UserAttendanceModelBase other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.userRegistration == userRegistration &&
        other.isPresent == isPresent;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ userName.hashCode ^ userRegistration.hashCode ^ isPresent.hashCode;
  }
}

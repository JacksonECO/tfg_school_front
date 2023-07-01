import 'dart:math';

import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/model/user_attendance_model.dart';
import 'package:tfg_front/src/service/attendance_service.dart';

class AttendanceServiceMock implements AttendanceService {
  Future<void> _delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<PaginationData<AttendanceModel>> getAttendancePaginated(
    PaginationData<AttendanceModel> pagination,
    int subjectId,
  ) async {
    await _delay();

    return PaginationData<AttendanceModel>(
      data: [
        AttendanceModel(
          id: 0,
          schoolId: 1,
          subjectId: 1,
          date: DateTime.now().subtract(const Duration(days: 0)),
          totalLesson: 1,
          users: listUser(true),
        ),
        AttendanceModel(
          id: 1,
          schoolId: 1,
          subjectId: 1,
          date: DateTime.now().subtract(const Duration(days: 1)),
          totalLesson: 2,
          users: listUser(true),
        ),
        AttendanceModel(
          id: 2,
          schoolId: 1,
          subjectId: 1,
          date: DateTime.now().subtract(const Duration(days: 2)),
          totalLesson: 3,
          users: listUser(true),
        ),
        AttendanceModel(
          id: 3,
          schoolId: 1,
          subjectId: 1,
          date: DateTime.now().subtract(const Duration(days: 3)),
          totalLesson: 14,
          users: listUser(true),
        ),
      ],
      rowsPerPage: 10,
      page: 1,
      totalElements: 4,
    );
  }

  @override
  Future<List<UserAttendanceModel>> getAttendanceUsers(int subjectId) async {
    await _delay();

    return listUser(false);
  }

  @override
  Future<void> register(AttendanceModel attendance) async {
    await _delay();
  }

  @override
  Future<void> update(AttendanceModel attendance) async {
    await _delay();
  }

  @override
  Future<void> delete(int id) async {
    await _delay();
  }

  @override
  Future<AttendanceModel> getAttendance(int id) async {
    await _delay();
    return AttendanceModel(
      id: 3,
      schoolId: 1,
      subjectId: 1,
      date: DateTime.now().subtract(const Duration(days: 3)),
      totalLesson: 14,
      users: listUser(true),
    );
  }

  bool present(bool isRandom) {
    if (isRandom) {
      return Random().nextBool();
    } else {
      return true;
    }
  }

  List<UserAttendanceModel> listUser(bool isRandom) {
    return [
      UserAttendanceModel(
        userId: 1,
        userName: 'John Smith',
        userRegistration: '457812',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 2,
        userName: 'Emily Johnson',
        userRegistration: '690234',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 3,
        userName: 'Michael Williams',
        userRegistration: '821576',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 4,
        userName: 'Emma Jones',
        userRegistration: '194785',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 5,
        userName: 'Daniel Brown',
        userRegistration: '684320',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 6,
        userName: 'Olivia Davis',
        userRegistration: '913687',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 7,
        userName: 'Matthew Miller',
        userRegistration: '832156',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 8,
        userName: 'Ava Wilson',
        userRegistration: '381042',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 9,
        userName: 'William Taylor',
        userRegistration: '529487',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 10,
        userName: 'Sophia Anderson',
        userRegistration: '647892',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 11,
        userName: 'James Martinez',
        userRegistration: '810245',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 12,
        userName: 'Isabella Johnson',
        userRegistration: '475906',
        isPresent: present(isRandom),
      ),
      UserAttendanceModel(
        userId: 13,
        userName: 'Benjamin Thompson',
        userRegistration: '680123',
        isPresent: present(isRandom),
      ),
    ];
  }
}

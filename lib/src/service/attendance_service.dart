import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/model/user_attendance_model.dart';
import 'package:tfg_front/src/service/user_service.dart';

class AttendanceService {
  final _dio = Modular.get<CustomHttp>();
  final _userService = Modular.get<UserService>();

  Future<AttendanceModel> getAttendance(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/attendance/$id');
    return AttendanceModel.fromMap(response.data!);
  }

  Future<List<UserAttendanceModel>> getAttendanceUsers(int classId) async {
    final listUser = await _userService.getUsers(classId: classId, AuthRoleEnum.student);

    return listUser
        .map<UserAttendanceModel>(
          (e) => UserAttendanceModel(
            userId: e.id!,
            userName: e.name!,
            userRegistration: e.registration!,
            isPresent: true,
          ),
        )
        .toList();
  }

  Future<PaginationData<AttendanceModel>> getAttendancePaginated(
    PaginationData<AttendanceModel> pagination,
    int subjectId,
  ) async {
    Map? response = await _dio.get<Map?>(
      '/attendance/paginated',
      queryParameters: {
        'subjectId': subjectId,
        'rowsPerPage': pagination.rowsPerPage,
        'page': pagination.page,
      },
    ).then((value) => value.data);

    if (response?['data'] == null) {
      return PaginationData<AttendanceModel>(
        data: [],
        rowsPerPage: pagination.rowsPerPage,
        page: pagination.page,
        totalElements: 0,
      );
    }

    List<AttendanceModel> list =
        response!['data'].map<AttendanceModel>((e) => AttendanceModel.fromMap(e)).toList();

    return PaginationData<AttendanceModel>(
      data: list,
      rowsPerPage: pagination.rowsPerPage,
      page: pagination.page,
      totalElements: response['total'],
    );
  }

  Future<void> register(AttendanceModel attendance) async {
    final Map<String, dynamic>? data = await _dio
        .post<Map<String, dynamic>>('/attendance/register', data: attendance.toMap())
        .then((value) => value.data);

    if (data == null) {
      throw CustomException(
        message: 'Erro ao registrar chamada',
        error: data,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> update(AttendanceModel attendance) async {
    final Map<String, dynamic>? data = await _dio
        .patch<Map<String, dynamic>>('/attendance', data: attendance.toMap())
        .then((value) => value.data);

    if (data == null) {
      throw CustomException(
        message: 'Erro ao registrar attendance',
        error: data,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> delete(int id) async {
    await _dio.delete<Map<String, dynamic>>('/attendance/$id');
  }
}

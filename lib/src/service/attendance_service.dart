import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/model/user_attendance_model.dart';

class AttendanceService {
  final _dio = Modular.get<CustomHttp>();

  Future<AttendanceModel> getAttendance(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/attendance/$id');
    return AttendanceModel.fromMap(response.data!);
  }

  Future<List<UserAttendanceModel>> getAttendanceUsers(int classId) async {
    return <UserAttendanceModel>[];
  }

  Future<PaginationData<AttendanceModel>> getAttendancePaginated(
    PaginationData<AttendanceModel> pagination,
  ) async {
    Map? response = await _dio.get<Map?>(
      '/attendance/paginated',
      queryParameters: {
        'rowsPerPage': pagination.rowsPerPage,
        'page': pagination.page,
        'search': pagination.search,
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
        message: 'Erro ao registrar attendance',
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

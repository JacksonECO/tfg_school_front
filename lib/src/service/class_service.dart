import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/class_model.dart';
import 'package:tfg_front/src/model/class_with_subject_model.dart';
import 'package:tfg_front/src/model/pagination_data.dart';

class ClassService {
  final _dio = Modular.get<CustomHttp>();

  Future<ClassWithSubjectModel> getClassWithSubject(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/class/$id');
    return ClassWithSubjectModel.fromMap(response.data!);
  }

  Future<List<ClassModel>> allClass() async {
    final response = await _dio.get<List<dynamic>>('/class');
    return response.data!.map((e) => ClassModel.fromMap(e)).toList();
  }

  Future<PaginationData<ClassModel>> getClassPaginated(
    PaginationData<ClassModel> pagination,
  ) async {
    Map? response = await _dio.get<Map?>(
      '/class/paginated',
      queryParameters: {
        'rowsPerPage': pagination.rowsPerPage,
        'page': pagination.page,
        'search': pagination.search,
      },
    ).then((value) => value.data);

    if (response?['data'] == null) {
      return PaginationData<ClassModel>(
        data: [],
        rowsPerPage: pagination.rowsPerPage,
        page: pagination.page,
        totalElements: 0,
      );
    }

    List<ClassModel> list =
        response!['data'].map<ClassModel>((e) => ClassModel.fromMap(e)).toList();

    return PaginationData<ClassModel>(
      data: list,
      rowsPerPage: pagination.rowsPerPage,
      page: pagination.page,
      totalElements: response['total'],
    );
  }

  Future<void> register(ClassWithSubjectModel classWithSubject) async {
    final Map<String, dynamic>? data = await _dio
        .post<Map<String, dynamic>>('/class/register', data: classWithSubject.toMap())
        .then((value) => value.data);

    if (data == null) {
      throw CustomException(
        message: 'Erro ao registrar class',
        error: data,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> update(ClassWithSubjectModel classWithSubject) async {
    final Map<String, dynamic>? data = await _dio
        .patch<Map<String, dynamic>>('/class', data: classWithSubject.toMap())
        .then((value) => value.data);

    if (data == null) {
      throw CustomException(
        message: 'Erro ao registrar class',
        error: data,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> delete(int id) async {
    await _dio.delete<Map<String, dynamic>>('/class/$id');
  }
}

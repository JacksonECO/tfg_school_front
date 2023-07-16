import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';

class ModuleCourseService {
  final _dio = Modular.get<CustomHttp>();

  Future<List<ModuleCourseModel>> allModule(int subjectId) async {
    final response = await _dio.get<List<dynamic>>('/module/', queryParameters: {
      'subjectId': subjectId,
    });

    return response.data!.map((e) => ModuleCourseModel.fromMap(e)).toList();
  }

  Future<void> delete(int id) async {
    await _dio.delete('/module/delete', queryParameters: {'id': id});
  }

  Future<void> update(ModuleCourseModel module) async {
    await _dio.patch('/module/update', data: module.toMap());
  }

  Future<int?> create(ModuleCourseModel module) async {
    final response = await _dio.post('/module/register', data: module.toMap());
    return response.data['id'];
  }

  Future<String> sendResponse({
    required ItemModuleCourseModel item,
    required ItemModuleCourseModel response,
    required int subjectId,
    required int studentId,
  }) async {
    final resp = await _dio.post('/grade/quiz', data: {
      'studentId': studentId,
      'subjectId': subjectId,
      'response': response.toMap(),
      'item': item.toMap(),
    });
    return resp.data['message'];
  }
}

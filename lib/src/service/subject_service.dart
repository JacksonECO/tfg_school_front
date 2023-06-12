import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/subject_model.dart';

class SubjectService {
  final _dio = Modular.get<CustomHttp>();

  Future<List<SubjectModel>> allSubjects(int classId) async {
    final response =
        await _dio.get<List<dynamic>>('/subject/', queryParameters: {
      'class_id': classId,
    });
    return response.data!.map((e) => SubjectModel.fromMap(e)).toList();
  }

  Future<SubjectModel?> find(int id, int schoolId) async {
    try {
      final response = await _dio
          .get<Map<String, dynamic>>('/subject/$id', queryParameters: {
        'schoolId': schoolId,
      });
      return SubjectModel.fromMap(response.data!);
    } on CustomException catch (e, s) {
      log('Erro ao buscar notícia', error: e, stackTrace: s);
    }
    return null;
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/subject_model.dart';

class SubjectService {
  final _dio = Modular.get<CustomHttp>();

  Future<List<SubjectModel>?> allSubjects(int classId) async {
    final response =
        await _dio.get<List<dynamic>>('/subject/', queryParameters: {
      'class_id': classId,
    });
    if(response.data == null) return null;
    return response.data!.map((e) => SubjectModel.fromMap(e)).toList();
  }
}

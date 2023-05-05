import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/module/school/model/class_model.dart';

class ClassService {
  final _dio = Modular.get<CustomHttp>();

  Future<List<ClassModel>> allClass() async {
    final response = await _dio.get<List<dynamic>>('/class');
    return response.data!.map((e) => ClassModel.fromMap(e)).toList();
  }
}

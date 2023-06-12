import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/dissert_resouce_model.dart';
import 'package:tfg_front/src/model/file_resource_model.dart';
import 'package:tfg_front/src/model/fill_the_blanks_resouce_model.dart';
import 'package:tfg_front/src/model/link_resouce_model.dart';
import 'package:tfg_front/src/model/module_course_model.dart';
import 'package:tfg_front/src/model/quiz_resouce_model.dart';
import 'package:tfg_front/src/model/text_resource.model.dart';

class ModuleCourseService {
  final _dio = Modular.get<CustomHttp>();
  static final resources = [];

  Future<List<ModuleCourseModel>> allModule(int subjectId) async {
    resources.clear();
    final response =
        await _dio.get<List<dynamic>>('/module/', queryParameters: {
      'subjectId': subjectId,
    });

    for (var e in response.data!) {
      if (e['content'] != null) {
        for (var value in e['content'].values) {
          switch (value['type']) {
            case 'text':
              resources.add(TextResourceModel.fromMap(value));
              break;
            case 'file':
              resources.add(FileResourceModel.fromMap(value));
              break;
            case 'link':
              resources.add(LinkResourceModel.fromMap(value));
              break;
            /*case 'quiz': TODO
            resources.add(QuizResourceModel.fromMap(value));
            break;
          case 'dissert':
            resources.add(DissertResourceModel.fromMap(value));
            break;
          case 'fill_the_blanks':
            resources.add(FillTheBlanksResourceModel.fromMap(value));
            break;*/
          }
        }
      }
    }
    return response.data!.map((e) => ModuleCourseModel.fromMap(e)).toList();
  }

  Future<void> delete(int moduleId) async {
    await _dio.delete('/module/delete', queryParameters: {
      'id': moduleId,
    });
  }

  Future<void> update(
      {required int moduleId,
      String? title,
      String? descripton,
      String? content,
      int? ordenation}) async {
    await _dio.patch('/module/update', data: {
      "id": moduleId,
      if (title != null) "title": title,
      if (descripton != null) "description": descripton,
      if (content != null) "content": content,
      if (ordenation != null) "ordenation": ordenation,
    });
  }

  Future<void> create(title, description, subjectId, ordenation) async {
    await _dio.post('/module/register', data: {
      "title": title,
      "description": description,
      "subjectId": subjectId,
      "ordenation": ordenation
    });
  }
}

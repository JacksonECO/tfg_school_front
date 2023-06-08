import 'dart:developer';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/module/user/model/news_model.dart';

class NewsService {
  final _dio = Modular.get<CustomHttp>();

  Future<List<NewsModel>?> find(int subjectId) async {
    try {
      final result = await _dio.get<List>(
        '/news/',
        queryParameters: {
          'subjectId': subjectId,
        },
      );
      return result.data!.map((e) => NewsModel.fromMap(e)).toList() ;
    } on CustomException catch (e, s) {
      log('Erro ao buscar notícia', error: e, stackTrace: s);
      if(e.statusCode == 404) {
        return null;
      }
    }
    return null;
  }
}

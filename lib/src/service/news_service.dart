import 'dart:developer';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/news_model.dart';

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
      return result.data!.map((e) => NewsModel.fromMap(e)).toList();
    } on CustomException catch (e, s) {
      log('Erro ao buscar notícia', error: e, stackTrace: s);
      if (e.statusCode == 404) {
        return null;
      }
    }
    return null;
  }

  Future<void> delete(NewsModel news) async {
    try {
      await _dio.delete('/news/delete/', queryParameters: {
        "id": news.id,
        "schoolId": news.schoolId,
      });
    } on CustomException catch (e, s) {
      log('Erro ao excluir notícia', error: e, stackTrace: s);
    }
  }

  Future<void> add(NewsModel news) async {
    try {
      await _dio.post('/news/register', data: {
        "title": news.title,
        "description": news.description,
        "schoolId": news.schoolId,
        "subjectId": news.subjectId,
        "classId": news.classId,
      });
    } on CustomException catch (e, s) {
      log('Erro ao adicionar notícia', error: e, stackTrace: s);
    }
  }

  Future<void> update(NewsModel news) async {
    try {
      await _dio.patch('/news/update', data: {
        "id": news.id,
        "title": news.title,
        "description": news.description,
        "school_id": news.schoolId,
        "subject_id": news.subjectId,
        "class_id": news.classId,
      });
    } on CustomException catch (e, s) {
      log('Erro ao adicionar notícia', error: e, stackTrace: s);
    }
  }
}

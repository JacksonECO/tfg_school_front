import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/news_model.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/model/subject_news_model.dart';
import 'package:tfg_front/src/service/news_service.dart';
import 'package:tfg_front/src/service/subject_service.dart';

part 'news_controller.g.dart';

enum NewsStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class NewsController = NewsControllerBase with _$NewsController;

abstract class NewsControllerBase with Store {
  final _newsService = Modular.get<NewsService>();
  final _subjectService = Modular.get<SubjectService>();
  final _auth = Modular.get<AuthModel>();

  @readonly
  List<SubjectNewsModel> _allNews = [];

  set setAllNews(List<SubjectNewsModel> newsList) {
    _allNews = newsList;
  }

  @action
  Future<bool> loadSubjects() async {
    try {
      if (_allNews.isNotEmpty) return true;
      var listSubjects = _auth.role == AuthRoleEnum.teacher
          ? await _subjectService.allSubjects(teacherId: _auth.userId)
          : await _subjectService.allSubjects(classId: _auth.classId);
      if (listSubjects != []) {
        for (var subject in listSubjects) {
          await loadNews(subject);
        }
      }
      return true;
    } catch (e, s) {
      log('Erro ao buscar disciplinas', error: e, stackTrace: s);
      return false;
    }
  }

  @action
  Future<void> loadNews(SubjectModel subject) async {
    try {
      var newsBySubject = await _newsService.find(subject.id!);
      _allNews.add(SubjectNewsModel.news(news: newsBySubject, subject: subject));
    } catch (e, s) {
      log('Erro ao buscar notícias', error: e, stackTrace: s);
    }
  }

  Future<void> removeNews(NewsModel news) async {
    try {
      await _newsService.delete(news);
    } catch (e, s) {
      log('Erro ao excluir notícia', error: e, stackTrace: s);
    }
  }

  Future<void> addNews(NewsModel news) async {
    try {
      await _newsService.add(news);
    } catch (e, s) {
      log('Erro ao adicionar notícia', error: e, stackTrace: s);
    }
  }

  Future<void> updateNews(NewsModel news) async {
    try {
      await _newsService.update(news);
    } catch (e, s) {
      log('Erro ao atualizar notícia', error: e, stackTrace: s);
    }
  }
}

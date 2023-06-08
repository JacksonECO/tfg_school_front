// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsController on NewsControllerBase, Store {
  late final _$_allNewsAtom =
      Atom(name: 'NewsControllerBase._allNews', context: context);

  List<SubjectNewsModel> get allNews {
    _$_allNewsAtom.reportRead();
    return super._allNews;
  }

  @override
  List<SubjectNewsModel> get _allNews => allNews;

  @override
  set _allNews(List<SubjectNewsModel> value) {
    _$_allNewsAtom.reportWrite(value, super._allNews, () {
      super._allNews = value;
    });
  }

  late final _$loadSubjectsAsyncAction =
      AsyncAction('NewsControllerBase.loadSubjects', context: context);

  @override
  Future<bool> loadSubjects() {
    return _$loadSubjectsAsyncAction.run(() => super.loadSubjects());
  }

  late final _$loadNewsAsyncAction =
      AsyncAction('NewsControllerBase.loadNews', context: context);

  @override
  Future<void> loadNews(SubjectModel subject) {
    return _$loadNewsAsyncAction.run(() => super.loadNews(subject));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

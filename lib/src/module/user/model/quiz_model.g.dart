// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizModel on _QuizModelBase, Store {
  late final _$indexSolutionAtom =
      Atom(name: '_QuizModelBase.indexSolution', context: context);

  @override
  int get indexSolution {
    _$indexSolutionAtom.reportRead();
    return super.indexSolution;
  }

  @override
  set indexSolution(int value) {
    _$indexSolutionAtom.reportWrite(value, super.indexSolution, () {
      super.indexSolution = value;
    });
  }

  @override
  String toString() {
    return '''
indexSolution: ${indexSolution}
    ''';
  }
}

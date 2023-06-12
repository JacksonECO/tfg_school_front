import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/class_model.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/service/class_service.dart';
part 'list_class_controller.g.dart';

class ListClassController = _ListClassControllerBase with _$ListClassController;

abstract class _ListClassControllerBase with Store {
  final ClassService _service = Modular.get<ClassService>();

  bool _hasData = false;

  @readonly
  @observable
  PaginationData<ClassModel> _pagination = PaginationData<ClassModel>(
    data: [],
    rowsPerPage: 10,
    page: 1,
    totalElements: 1,
  );

  @computed
  List<ClassModel> get data => _pagination.data;

  void search(String input) async {
    try {
      EasyLoading.show();
      _pagination = await _service.getClassPaginated(_pagination.copyWith(page: 1, search: input));
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro search', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }

  Future<bool> get future async {
    if (_hasData) return true;

    try {
      EasyLoading.show();
      _pagination = await _service.getClassPaginated(_pagination);
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro future', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }

    return _hasData = true;
  }

  Future<void> goTo(int? page) async {
    try {
      EasyLoading.show();
      _pagination = await _service.getClassPaginated(_pagination.copyWith(page: page));
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro toPage', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }

  Future<void> remove(int index) async {
    await _service.delete(data[index].id!);
    data.removeAt(index);
  }
}

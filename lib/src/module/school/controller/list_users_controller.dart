import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/service/user_service.dart';
import 'package:mobx/mobx.dart';
part 'list_users_controller.g.dart';

class ListUsersController = _ListUsersControllerBase with _$ListUsersController;

abstract class _ListUsersControllerBase with Store {
  final UserService _service = Modular.get<UserService>();

  _ListUsersControllerBase();

  bool _hasData = false;
  PaginationData<UserModel> _pagination = PaginationData<UserModel>(
    data: [],
    rowsPerPage: 10,
    page: 0,
    totalElements: 1,
  );

  int get totalPage => _pagination.totalPage;
  int get page => _pagination.page;
  List<UserModel> get users => _pagination.data;

  void search(String input) async {
    try {
      EasyLoading.show();
      _pagination = await _service.getUsersPaginated(_pagination.copyWith(page: 0, search: input));
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
      _pagination = await _service.getUsersPaginated(_pagination);
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro future', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }

    return _hasData = true;
  }

  void goTo(int page) async {
    try {
      EasyLoading.show();
      _pagination = await _service.getUsersPaginated(_pagination.copyWith(page: page));
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro toPage', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }
}
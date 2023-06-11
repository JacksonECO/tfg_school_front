import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/service/user_service.dart';
import 'package:mobx/mobx.dart';
part 'list_users_controller.g.dart';

class ListUsersController = _ListUsersControllerBase with _$ListUsersController;

abstract class _ListUsersControllerBase with Store {
  final UserService _service = Modular.get<UserService>();
  final AuthRoleEnum typeUser;
  _ListUsersControllerBase({
    required this.typeUser,
  });

  bool _hasData = false;
  @observable
  PaginationData<UserModel> _pagination = PaginationData<UserModel>(
    data: [],
    rowsPerPage: 10,
    page: 1,
    totalElements: 1,
  );

  int get totalPage => _pagination.totalPage;
  int get page => _pagination.page;
  List<UserModel> get users => _pagination.data;
  PaginationData<UserModel> get pagination => _pagination;

  void search(String input) async {
    try {
      EasyLoading.show();
      _pagination = await _service.getUsersPaginated(
          _pagination.copyWith(
            page: 1,
            search: input,
          ),
          typeUser);
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
      _pagination = await _service.getUsersPaginated(_pagination, typeUser);
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
      _pagination = await _service.getUsersPaginated(_pagination.copyWith(page: page), typeUser);
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro toPage', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }

  Future<void> removeUser(int id) async {
    try {
      EasyLoading.show();
      await _service.remove(id);
      await goTo(null);
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro removeUser', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }
}

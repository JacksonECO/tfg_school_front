import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/class_model.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/service/class_service.dart';

class UserService {
  final _dio = Modular.get<CustomHttp>();
  final _classService = Modular.get<ClassService>();

  Future<UserModel?> getUser(int id) async {
    final temp = (await _dio.get<Map<String, dynamic>>('/user/$id')).data;

    if (temp == null) return null;
    return UserModel.fromMap(temp);
  }

  Future<PaginationData<UserModel>> getUsersPaginated(
    PaginationData<UserModel> pagination,
    AuthRoleEnum type,
  ) async {
    Map? temp;
    List<ClassModel>? listClass;

    await Future.wait([
      _dio.get<Map>(
        '/user/paginated',
        queryParameters: {
          'rowsPerPage': pagination.rowsPerPage,
          'page': pagination.page,
          'search': pagination.search,
          'role': type,
        },
      ).then((value) => temp = value.data),

      ///
      _classService.allClass().then(
            (value) => listClass = value,
          ),
    ]);

    if (temp?['data'] == null) {
      return PaginationData<UserModel>(
        data: [],
        rowsPerPage: pagination.rowsPerPage,
        page: pagination.page,
        totalElements: 0,
      );
    }

    List<UserModel> list = temp!['data'].map<UserModel>((e) => UserModel.fromMap(e)).toList();

    // Busca ClassName
    for (var element in list) {
      element.className = listClass!
          .firstWhere(
            (e) => e.id == element.classId,
            orElse: () => ClassModel(),
          )
          .name;
    }

    return PaginationData<UserModel>(
      data: list,
      rowsPerPage: pagination.rowsPerPage,
      page: pagination.page,
      totalElements: temp!['total'],
    );
  }

  Future<List<UserModel>> getUsers(AuthRoleEnum type) async {
    final temp = await _dio.get<List>('/user', queryParameters: {
      'role': type.name,
    }).then((value) {
      return value.data;
    });

    if (temp == null) return [];
    return temp.map<UserModel>((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> remove(int id) async {
    await _dio.delete<Map<String, dynamic>>('/user/$id');
  }
}

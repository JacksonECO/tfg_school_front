import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/model/user_model.dart';

class UserService {
  final _dio = Modular.get<CustomHttp>();

  Future<UserModel?> getUser(int id) async {
    final temp = (await _dio.get<Map<String, dynamic>>('/user/$id')).data;

    if (temp == null) return null;
    return UserModel.fromMap(temp);
  }

  Future<PaginationData<UserModel>> getUsersPaginated(
    PaginationData<UserModel> pagination,
  ) async {
    final temp = (await _dio.get<List<dynamic>>(
      '/user',
      queryParameters: {
        'rowsPerPage': pagination.rowsPerPage,
        'page': pagination.page,
        'search': pagination.search,
      },
    ))
        .data;

    if (temp == null) {
      return PaginationData<UserModel>(
        data: [],
        rowsPerPage: pagination.rowsPerPage,
        page: pagination.page,
        totalElements: 0,
      );
    }

    final list = temp.map((e) => UserModel.fromMap(e)).toList();
    return PaginationData<UserModel>(
      data: list,
      rowsPerPage: pagination.rowsPerPage,
      page: pagination.page,
      totalElements: list.length,
    );
  }
}

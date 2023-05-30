
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
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
  ) async {
    List<dynamic>? temp;
    List<ClassModel>? listClass;

    await Future.wait([
      _dio.get<List<dynamic>>(
        '/user',
        queryParameters: {
          'rowsPerPage': pagination.rowsPerPage,
          'page': pagination.page,
          'search': pagination.search,
        },
      ).then((value) => temp = value.data),

      ///
      _classService.allClass().then(
            (value) => listClass = value,
          ),
    ]);

    if (temp == null) {
      return PaginationData<UserModel>(
        data: [],
        rowsPerPage: pagination.rowsPerPage,
        page: pagination.page,
        totalElements: 0,
      );
    }

    final list = temp!.map((e) => UserModel.fromMap(e)).toList();

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
      totalElements: list.length,
    );
  }

  remove(int id) async {
    await _dio.delete<Map<String, dynamic>>('/user/$id');
  }
}

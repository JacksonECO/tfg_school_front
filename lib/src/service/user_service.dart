import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/user_model.dart';

class UserService {
  final _dio = Modular.get<CustomHttp>();

  Future<UserModel?> getUser(int id) async {
    final temp = (await _dio.get<Map<String, dynamic>>('/user/$id')).data;

    if (temp == null) return null;
    return UserModel.fromMap(temp);
  }
}

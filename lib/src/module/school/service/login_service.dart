import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';

class SchoolProfileService {
  final dio = Modular.get<CustomHttp>();

  // Future<bool> login(String username, String password) async {}

  Future register(SchoolModel school, FileModel? image) async {
    await dio.post(
      '/school/register',
      data: {
        ...school.toMap(),
        if (image != null) 'newLogo': image.toMap(),
      },
    );
  }
}

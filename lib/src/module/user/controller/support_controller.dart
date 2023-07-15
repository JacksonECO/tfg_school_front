import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';
import 'package:tfg_front/src/service/login_service.dart';

class SupportController {
  final LoginService _service = Modular.get<LoginService>();
  final AuthModel auth = Modular.get<AuthModel>();

  bool _hasDate = false;
  String email = '';
  String phone = '';

  Future<bool> get future async {
    if (_hasDate) return true;

    SchoolModel school = await _service.getSchool();
    email = school.email;
    phone = school.phone;

    return _hasDate = true;
  }
}

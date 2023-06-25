import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/service/attendance_service.dart';

class ListAttendanceController {
  final AttendanceService _service = Modular.get<AttendanceService>();
  final int subjectId;

  ListAttendanceController({
    required this.subjectId,
  });

  bool _hasData = false;

  PaginationData<AttendanceModel> get pagination => _pagination;
  PaginationData<AttendanceModel> _pagination = PaginationData<AttendanceModel>(
    data: [],
    rowsPerPage: 10,
    page: 1,
    totalElements: 1,
  );

  List<AttendanceModel> get data => _pagination.data;

  Future<bool> get future async {
    if (_hasData) return true;

    try {
      EasyLoading.show();
      _pagination = await _service.getAttendancePaginated(_pagination);
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
      _pagination = await _service.getAttendancePaginated(_pagination.copyWith(page: page));
      EasyLoading.dismiss();
    } catch (e, s) {
      log('Erro toPage', error: e, stackTrace: s);
      EasyLoading.dismiss();
    }
  }
}

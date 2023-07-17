import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/user/controller/module_course_controller.dart';
import 'package:tfg_front/src/module/user/model/basic_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/widget/resources/resource_basic_widget.dart';
import 'package:tfg_front/src/module/user/widget/resources/resource_quiz_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum ItemModuleCourseEnum {
  text('Texto'),
  // file('Arquivo'),
  link('Link'),
  quiz('Quiz'),
  dissert('Dissertativo');
  // fillTheBlanks('Preencher lacunas');

  final String title;
  const ItemModuleCourseEnum(this.title);

  static ItemModuleCourseEnum? fromString(String? value) {
    try {
      if (value == null) return null;
      return ItemModuleCourseEnum.values.firstWhere(
        (element) => element.name == value || element.title == value,
      );
    } catch (e) {
      return null;
    }
  }

  Color get color {
    switch (this) {
      case ItemModuleCourseEnum.text:
      case ItemModuleCourseEnum.link:
        return CustomColors.i.backgroundTitle;

      case ItemModuleCourseEnum.quiz:
      case ItemModuleCourseEnum.dissert:
        return CustomColors.i.greenBlue;
    }
  }

  String get pathIcon {
    switch (this) {
      // case ItemModuleCourseEnum.fillTheBlanks:
      //   return 'assets/icon/fill-the-blanks-resource.png';
      default:
        return 'assets/icon/$name-resource.png';
    }
  }

  bool get _isProf => Modular.get<AuthModel>().role == AuthRoleEnum.teacher;

  Widget tile({
    required ItemModuleCourseModel item,
    required BuildContext context,
    required ModuleCouseController controller,
    required int indexModule,
  }) {
    switch (this) {
      case ItemModuleCourseEnum.link:
      case ItemModuleCourseEnum.text:
        final basic = item as BasicItemModuleCourseModel;
        return ResourceBasicWidget.tile(
          item: item,
          onTap: () {
            if (item.type == ItemModuleCourseEnum.text) {
              ResourceBasicWidget(module: item, onlyView: true).openModal(context);
            } else if (item.type == ItemModuleCourseEnum.link) {
              launchUrlString(basic.content);
            }
          },
          onEdit: () async {
            final resource = await ResourceBasicWidget(module: item).openModal(context);
            if (resource == null) return;

            controller.editItem(indexModule, item, resource);
          },
          onDelete: () {
            controller.removeItem(indexModule, item);
          },
        );
      case ItemModuleCourseEnum.quiz:
        final quiz = item as QuizItemModuleCourseModel;
        return ResourceQuizWidget.tile(
          item: item,
          onTap: () async {
            if (_isProf) {
              ResourceQuizWidget(module: quiz, onlyView: true).openModal(context);
              return;
            }

            final copy = quiz.copyWith();
            copy.cleanResponses();

            final response = await ResourceQuizWidget(module: copy, isDoing: true).openModal(context);
            if (response == null) return;

            controller.sendResponse(indexModule, item, response);
          },
          onEdit: () async {
            final resource = await ResourceQuizWidget(module: quiz).openModal(context);
            if (resource == null) return;

            controller.editItem(indexModule, item, resource);
          },
          onDelete: () {
            controller.removeItem(indexModule, item);
          },
        );

      case ItemModuleCourseEnum.dissert:
        throw UnimplementedError();
    }
  }
}

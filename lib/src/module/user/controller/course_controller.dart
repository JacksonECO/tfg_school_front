import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/link_resouce_model.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/model/text_resource.model.dart';
import 'package:tfg_front/src/service/module_course_service.dart';
import 'package:tfg_front/src/service/subject_service.dart';
import 'package:tfg_front/src/model/module_course_model.dart';
import 'package:uuid/uuid.dart';
part 'course_controller.g.dart';

enum CourseStateStatus {
  loading,
  loaded,
  error,
}

class CourseController = CourseControllerBase with _$CourseController;

abstract class CourseControllerBase with Store {
  @readonly
  var _status = CourseStateStatus.loading;

  @readonly
  String? _messageError;

  @readonly
  SubjectModel? _subject;

  @readonly
  List<ModuleCourseModel> _modulesCourse = [];

  @readonly
  List<dynamic> _resources = [];

  Uuid uuid = Uuid();

  final _subjectService = Modular.get<SubjectService>();
  final _moduleCourseService = Modular.get<ModuleCourseService>();
  final _auth = Modular.get<AuthModel>();

  @action
  Future<void> loadSubject(int subjectId) async {
    try {
      _status = CourseStateStatus.loading;
      _subject = await _subjectService.find(subjectId, _auth.schoolId!);
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar curso', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao carregar curso';
    }
  }

  @action
  Future<void> loadModules(int subjectId) async {
    try {
      _status = CourseStateStatus.loading;
      _modulesCourse = await _moduleCourseService.allModule(subjectId);
      _resources = ModuleCourseService.resources;
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar módulos', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao carregar módulos';
    }
  }

  @action
  Future<void> createModule(
      String title, String description, int subjectId) async {
    try {
      _status = CourseStateStatus.loading;
      await _moduleCourseService.create(
          title,
          description,
          subjectId,
          _modulesCourse.isNotEmpty
              ? _modulesCourse[_modulesCourse.length - 1].ordenation + 1
              : 1);
      await loadSubject(subjectId);
      await loadModules(subjectId);
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao criar módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao criar módulo';
    }
  }

  @action
  Future<void> deleteModule(int moduleId, int subjectId) async {
    try {
      _status = CourseStateStatus.loading;
      await _moduleCourseService.delete(moduleId);
      await loadSubject(subjectId);
      await loadModules(subjectId);
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao deletar módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao deletar módulo';
    }
  }

  @action
  Future<void> updateModule(
      {required int moduleId,
      String? title,
      String? descripton,
      String? content,
      int? ordenation,
      bool update = true,
      required int subjectId}) async {
    try {
      _status = CourseStateStatus.loading;
      await _moduleCourseService.update(
          moduleId: moduleId,
          title: title,
          descripton: descripton,
          content: content,
          ordenation: ordenation);
      if (update) {
        await loadSubject(subjectId);
        await loadModules(subjectId);
      }
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao atualzar módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao atualzar módulo';
    }
  }

  //ordenation should always start in 1
  @action
  Future<void> handleUpModule(
      int moduleId, int subjectId, int ordenation) async {
    try {
      if (ordenation > _modulesCourse[0].ordenation) {
        int index = 0, indexTarget = 0;
        for (var module in _modulesCourse) {
          if (module.ordenation == ordenation) indexTarget = index;
          index++;
        }

        await updateModule(
          moduleId: moduleId,
          subjectId: subjectId,
          ordenation: _modulesCourse[indexTarget - 1].ordenation,
          update: false,
        );
        await updateModule(
            moduleId: _modulesCourse[indexTarget - 1].id,
            subjectId: subjectId,
            ordenation: ordenation);
      }
    } catch (e, s) {
      log('Erro ao atualzar ordem do módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao atualzar ordem do módulo';
    }
  }

  @action
  Future<void> handleDownModule(
      int moduleId, int subjectId, int ordenation) async {
    try {
      if (ordenation < _modulesCourse[_modulesCourse.length - 1].ordenation) {
        int index = 0, indexTarget = 0;
        for (var module in _modulesCourse) {
          if (module.ordenation == ordenation) indexTarget = index;
          index++;
        }
        await updateModule(
          moduleId: moduleId,
          subjectId: subjectId,
          ordenation: _modulesCourse[indexTarget + 1].ordenation,
          update: false,
        );
        await updateModule(
            moduleId: _modulesCourse[indexTarget + 1].id,
            subjectId: subjectId,
            ordenation: ordenation);
      }
    } catch (e, s) {
      log('Erro ao atualzar ordem do módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao atualzar ordem do módulo';
    }
  }

  List<dynamic> resourcesByModel(int modelId) {
    List<dynamic> listResources = [];
    int index = 0;
    for (var resource in _resources) {
      if (resource.moduleId == modelId) {
        listResources.add(resource);
        index++;
      }
    }
    return listResources;
  }

  String appendResources({dynamic newResource, required int moduleId}) {
    String allresources = '';
    int suffix = 1;
    int index = 0;
    
    for (var resource in resourcesByModel(moduleId)) {
      if (resource.moduleId == moduleId) {
        if (suffix == 1) {
          allresources +=
              '{"resource${suffix.toString()}":' + resource.toJson();
          if (resourcesByModel(moduleId).length == 1 && newResource == null) {
            allresources += '}';
          }
        } else {
          if (newResource != null ||
              index != resourcesByModel(moduleId).length - 1) {
            allresources +=
                ',"resource${suffix.toString()}":' + resource.toJson();
          } else if (index == resourcesByModel(moduleId).length - 1) {
            allresources +=
                ',"resource${suffix.toString()}":' + resource.toJson() + '}';
          }
        }
        suffix++;
      }
      index++;
    }
    if (newResource != null) {
      if (suffix == 1) {
        allresources +=
            '{"resource${suffix.toString()}":' + newResource.toJson() + '}';
      } else {
        allresources +=
            ',"resource${suffix.toString()}":' + newResource.toJson() + '}';
      }
    }
    return allresources;
  }

  @action
  Future<void> addResourceText(
      String title, String content, int moduleId) async {
    try {
      _status = CourseStateStatus.loading;
      TextResourceModel resource = TextResourceModel(
        type: 'text',
        title: title,
        content: content,
        moduleId: moduleId,
        id: uuid.v4(),
      );

      int index = 0, indexTarget = 0;
      for (var module in _modulesCourse) {
        if (module.id == moduleId) indexTarget = index;
        index++;
      }

      await updateModule(
          moduleId: moduleId,
          content: appendResources(newResource: resource, moduleId: moduleId),
          subjectId: _modulesCourse[indexTarget].subjectId);
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro aoadicionar recurso ao módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro aoadicionar recurso ao módulo';
    }
  }

  @action
  Future<void> addResourceLink(String title, String link, int moduleId) async {
    try {
      _status = CourseStateStatus.loading;
      LinkResourceModel resource = LinkResourceModel(
          type: 'link',
          title: title,
          link: link,
          moduleId: moduleId,
          id: uuid.v4());

      int index = 0, indexTarget = 0;
      for (var module in _modulesCourse) {
        if (module.id == moduleId) indexTarget = index;
        index++;
      }

      await updateModule(
          moduleId: moduleId,
          content: appendResources(newResource: resource, moduleId: moduleId),
          subjectId: _modulesCourse[indexTarget].subjectId);
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao adicionar recurso ao módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao adicionar recurso ao módulo';
    }
  }

  Future<void> updateResourceText(
      TextResourceModel editResource, String title, String content) async {
    try {
      _status = CourseStateStatus.loading;

      int index = 0;

      for (var resource in _resources) {
        if (resource.id == editResource.id) {
          _resources[index].title = title;
          _resources[index].content = content;
        }
        index++;
      }

      await updateModule(
        moduleId: editResource.moduleId,
        content: appendResources(moduleId: editResource.moduleId),
        subjectId: _modulesCourse
            .where((module) => module.id == editResource.moduleId)
            .first
            .subjectId,
      );
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao editar recurso ao módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao editar recurso ao módulo';
    }
  }

  Future<void> updateResourceLink(
      LinkResourceModel editResource, String title, String link) async {
    try {
      _status = CourseStateStatus.loading;

      int index = 0;

      for (var resource in _resources) {
        if (resource.id == editResource.id) {
          _resources[index].title = title;
          _resources[index].link = link;
        }
        index++;
      }

      await updateModule(
        moduleId: editResource.moduleId,
        content: appendResources(moduleId: editResource.moduleId),
        subjectId: _modulesCourse
            .where((module) => module.id == editResource.moduleId)
            .first
            .subjectId,
      );
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao editar recurso ao módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao editar recurso ao módulo';
    }
  }

  Future<void> removeResource(dynamic excludeResource) async {
    try {
      _status = CourseStateStatus.loading;
      int index = 0;

      for (var resource in _resources) {
        if (resource.id == excludeResource.id) {
          _resources.removeAt(index);
        }
        index++;
      }

      await updateModule(
        moduleId: excludeResource.moduleId,
        content: resourcesByModel(excludeResource.moduleId).isNotEmpty
            ? appendResources(moduleId: excludeResource.moduleId)
            : '{}',
        subjectId: _modulesCourse
            .where((module) => module.id == excludeResource.moduleId)
            .first
            .subjectId,
      );
      _status = CourseStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao excluir recurso do módulo', error: e, stackTrace: s);
      _status = CourseStateStatus.error;
      _messageError = 'Erro ao excluir recurso do módulo';
    }
  }
}

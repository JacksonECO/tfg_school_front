import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/circle_button.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/news_model.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:tfg_front/src/module/user/controller/news_controller.dart';

class ModalNewsWidget {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
  final newsController = NewsController();
  final actualCourse = Modular.get<CourseController>().subject;
  Future<void> showNews(BuildContext context, List<NewsModel> allNews) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Últimas Notícias',
            style: context.style.poppinsRegular.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          titlePadding: const EdgeInsets.only(top: 30, bottom: 20),
          backgroundColor: context.colors.secondary,
          content: ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 600, minHeight: 100, maxHeight: 700),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  crossAxisAlignment: allNews.isEmpty
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    ...allNews.map((news) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              final TextEditingController titleEC =
                                  TextEditingController(text: news.title);
                              final TextEditingController contentEC =
                                  TextEditingController(text: news.description);
                              Navigator.of(context).pop();
                              if (await ModalAlert.showTitleContent(
                                  title: 'Editar Notícia',
                                  titleEC: titleEC,
                                  contentEC: contentEC)) {
                                NewsModel updateNews = NewsModel(
                                  id: news.id,
                                  title: titleEC.text,
                                  description: contentEC.text,
                                  schoolId: news.schoolId,
                                  classId: news.classId,
                                  subjectId: news.subjectId,
                                );
                                newsController.updateNews(updateNews);
                              }
                            },
                            child: Container(
                              width: context.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: context.colors.inputAlertModal,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    news.title,
                                    style: context.style.title,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    news.description,
                                    style: context.style.text,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Data de publicação: ${formatter.format(news.updatedAt!)}',
                                    style: context.style.poppinsItalic.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: CircleButton(
                              color: context.colors.error,
                              icon: Icons.close,
                              onPressed: () async {
                                if (await ModalAlert.showConfirmRemove(
                                    'Deseja remover a notícia: ${news.title}?')) {
                                  newsController.removeNews(news);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                    Container(
                        width: 200,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Button.green(
                          text: 'Adicionar Notícia',
                          onPressed: () async {
                            final TextEditingController titleEC =
                                TextEditingController();
                            final TextEditingController contentEC =
                                TextEditingController();
                            Navigator.of(context).pop();
                            if (await ModalAlert.showTitleContent(
                                title: 'Adicionar Notícia',
                                titleEC: titleEC,
                                contentEC: contentEC)) {
                              NewsModel addNews = NewsModel(
                                title: titleEC.text,
                                description: contentEC.text,
                                schoolId: actualCourse!.schoolId,
                                classId: actualCourse!.classId,
                                subjectId: actualCourse!.id,
                              );
                              newsController.addNews(addNews);
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

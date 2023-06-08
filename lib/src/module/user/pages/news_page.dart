import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/controller/news_controller.dart';
import 'package:tfg_front/src/module/user/wiget/news_subject_item.dart';

class NewsPage extends StatefulWidget {
  final NewsController controller;

  const NewsPage({super.key, required this.controller});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        FutureBuilder<bool>(
          future: widget.controller.loadSubjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CrudViewer(
                title: 'Notícias',
                body: widget.controller.allNews
                    .where((e) => e.news != null && e.news!.isNotEmpty)
                    .map((e) => NewsSubjectItem(newsItem: e))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Não foi carregar as notícias',
                  style: context.style.poppinsMedium,
                ),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      color: context.colors.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Buscando Notícias...',
                      style: context.style.poppinsMedium,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

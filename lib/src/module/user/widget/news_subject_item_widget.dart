import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/pagination_data.dart';
import 'package:tfg_front/src/model/subject_news_model.dart';
import 'package:tfg_front/src/model/news_model.dart';

class NewsSubjectItemWidget extends StatefulWidget {
  final SubjectNewsModel newsItem;
  const NewsSubjectItemWidget({super.key, required this.newsItem});

  @override
  State<NewsSubjectItemWidget> createState() => _NewsSubjectItemWidgetState();
}

class _NewsSubjectItemWidgetState extends State<NewsSubjectItemWidget> {
  late final PaginationData<NewsModel> paginator;
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

  void goTo(int page) {
    paginator.page = page;
    setState(() {});
  }

  NewsModel get getNews {
    return widget.newsItem.news![paginator.page - 1];
  }

  @override
  void initState() {
    paginator = PaginationData(
      data: widget.newsItem.news ?? [],
      rowsPerPage: 1,
      totalElements: widget.newsItem.news?.length ?? 0,
      page: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.newsItem.news == null || widget.newsItem.news!.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SelectableText(
            widget.newsItem.name!,
            style: context.style.title,
          ),
        ),
        const Divider(
          color: Colors.white70,
          thickness: 2,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 30, top: 10),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: context.colors.gray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SelectableText(
                        getNews.title,
                        style: context.style.poppinsSemiBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SelectableText(
                      'Data de publicação: ${formatter.format(getNews.updatedAt!)}',
                      style: context.style.poppinsItalic.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                SelectableText(
                  getNews.description,
                  style: context.style.poppinsRegular.copyWith(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        PaginatorWidget(
          pagination: paginator,
          goTo: goTo,
        ),
      ],
    );
  }
}

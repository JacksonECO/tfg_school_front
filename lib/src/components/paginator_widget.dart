import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/model/pagination_data.dart';

class PaginatorWidget extends StatelessWidget {
  final PaginationData pagination;
  final void Function(int) goTo;
  const PaginatorWidget({super.key, required this.pagination, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (pagination.page > 1) {
                goTo(pagination.page - 1);
              }
            },
          ),
          _Pages(
            currentPage: pagination.page,
            totalPage: pagination.totalPage,
            goTo: goTo,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              if (pagination.page < pagination.totalPage) {
                goTo(pagination.page + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final void Function(int) goTo;
  const _Pages({required this.currentPage, required this.totalPage, required this.goTo});

  Widget element(int index) {
    if (index == 0) {
      return const IconButton(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        icon: Text('...'),
        onPressed: null,
      );
    }

    return IconButton(
      style: index == currentPage
          ? ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12))
          : null,
      icon: Text(index.toString()),
      onPressed: () => goTo(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    if (totalPage <= 5 || currentPage <= 3) {
      for (int i = 1; i <= min(totalPage, 5); i++) {
        list.add(element(i));
      }

      if (currentPage <= 3 && totalPage > 5) {
        if (totalPage > 6) list.add(element(totalPage == 7 ? 6 : 0));
        list.add(element(totalPage));
      }
    } else if (currentPage >= totalPage - 2) {
      list.add(element(1));
      if (totalPage > 6) list.add(element(totalPage == 7 ? 2 : 0));

      for (int i = totalPage - 4; i <= totalPage; i++) {
        list.add(element(i));
      }
    } else {
      list.add(element(1));
      list.add(element(totalPage == 7 ? 2 : 0));

      for (int i = currentPage - 1; i <= currentPage + 1; i++) {
        list.add(element(i));
      }

      list.add(element(totalPage == 7 ? 6 : 0));
      list.add(element(totalPage));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}

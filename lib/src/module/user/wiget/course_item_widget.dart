import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/bullet_list_item.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:intl/intl.dart';

class CourseItemWidget extends StatelessWidget {
  final SubjectModel subject;

  const CourseItemWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-1, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: subject.picture != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      subject.picture!,
                      height: double.infinity,
                    ),
                  )
                : Image.asset(
                    'assets/img/course-picture.png',
                    height: 150,
                  ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: context.colors.gray,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toBeginningOfSentenceCase(subject.name)!,
                    style: context.style.title,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BulletListItem(
                      text:
                          'Professor(a):  ${toBeginningOfSentenceCase(subject.teacherName)}'),
                  BulletListItem(
                      text:
                          'Turma: ${toBeginningOfSentenceCase(subject.className)}'),
                  BulletListItem(
                    text:
                        'Última modificação: ${formatter.format(subject.updatedAt!)}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

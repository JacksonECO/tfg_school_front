import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class CrudViewer extends StatelessWidget {
  final String title;
  final bool hasPadding;
  final bool hasScroll;
  final List<Widget> body;

  const CrudViewer({
    super.key,
    required this.title,
    required this.body,
    this.hasPadding = true,
    this.hasScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(
              top: 50.0,
              left: 50.0,
            ),
            decoration: BoxDecoration(
              color: context.colors.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Text(
              title,
              style: context.style.title,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 50.0),
          padding: hasPadding ? const EdgeInsets.all(50.0) : null,
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(5, 10), // changes position of shadow
              ),
            ],
          ),
          constraints:
              BoxConstraints(minWidth: 300, maxHeight: context.height - 150),
          child: hasScroll
              ? SingleChildScrollView(
                  child: Column(
                    children: body.isNotEmpty
                        ? body
                        : [
                            Center(
                              child: Text(
                                'Nenhum dado registrado',
                                style: context.style.poppinsMedium,
                              ),
                            ),
                          ],
                  ),
                )
              : Column(
                  children: body.isNotEmpty
                      ? body
                      : [
                          Center(
                            child: Text(
                              'Nenhum dado registrado',
                              style: context.style.poppinsMedium,
                            ),
                          ),
                        ],
                ),
        )
      ],
    );
  }
}

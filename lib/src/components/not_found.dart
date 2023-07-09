import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(5, 10),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SelectableText(
            'Ops!',
            style: context.style.poppinsBlack.copyWith(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Image.asset(
              'assets/img/error_404.gif',
              height: 400,
            ),
          ),
          SelectableText(
            'Parece que o recurso que você está procurando não existe...',
            style: context.style.poppinsMedium.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}

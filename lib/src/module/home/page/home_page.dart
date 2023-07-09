import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/custom_wrap.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';
import 'package:tfg_front/src/module/home/widget/footer_widget.dart';
import 'package:tfg_front/src/module/home/widget/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            blockNextLevel(context),
            blockPlatform(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget blockNextLevel(BuildContext context) {
    return Container(
      color: context.colors.backgroundPrimary,
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.07, vertical: max(40, context.width * 0.05)),
      child: CustomWrap(minRow: 800, children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'Eleve o sistema da sua Escola para um novo nível',
                  style: context.style.poppinsBold.copyWith(fontSize: min(45, max(30, context.width * 0.05))),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Com o BlackBoard você terá um sistema escolar centralizado. Dessa forma, os diferentes usuários que fazem parte do processo de aprendizagem, poderão fazer uso de uma única plataforma, tanto para administração acadêmica, quanto para ministração e consumo de cursos.',
                style: context.style.poppinsRegular.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Image.asset(
          'assets/img/next_level.png',
          width: max(400, context.width * 0.40),
        )
      ]),
    );
  }

  Widget blockPlatform(BuildContext context) {
    return Container(
      color: context.colors.backgroundTitle,
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.07, vertical: max(40, context.width * 0.05)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Porque escolher a plataforma BlackBoard?',
            style: context.style.poppinsBold.copyWith(fontSize: min(45, max(30, context.width * 0.05))),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          CustomWrap(
            crossAxisAlignment: CrossAxisAlignment.start,
            minRow: 800,
            children: [
              mineBlock(
                title: 'Design Moderno',
                pathIcon: 'assets/icon/design.png',
                description: 'A plataforma conta com padrões modernos de design que cativam a utilização e retenção de usuários.',
              ),
              const SizedBox.square(dimension: 28),
              mineBlock(
                title: 'Experiência Amigável',
                pathIcon: 'assets/icon/centralized.png',
                description:
                    'Experiência do usuário aprimorada através de recursos objetivos que contribuem para um mínimo esforço e máximo desempenho.',
              ),
              const SizedBox.square(dimension: 28),
              mineBlock(
                title: 'Ambiente Centralizado',
                pathIcon: 'assets/icon/role-model.png',
                description:
                    'Todos os diferentes perfis presentes no ambiente acadêmico fazem uso de uma única fonte, facilitando a manutenção do ecossistema.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mineBlock({
    required String title,
    required String pathIcon,
    required String description,
  }) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Row(
              children: [
                Image.asset(
                  pathIcon,
                  height: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: CustomTextStyle.i.poppinsBold.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          Text(
            description,
            style: CustomTextStyle.i.poppinsRegular.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

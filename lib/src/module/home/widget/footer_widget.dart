import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: context.colors.backgroundSecondary,
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.07, vertical: max(40, context.width * 0.05)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SelectableText(
            'Trabalho FINAL de Graduação'.toUpperCase(),
            style: context.style.poppinsBlack.copyWith(
              fontSize: 26,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          SelectableText(
            'Este trabalho foi feito com muito amor e dedicação para a conclusão do curso de Engenharia de Computação da UNIFEI - Universidade Federal de Itajubá.',
            style: context.style.interRegular.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          Divider(
            color: context.colors.grayDark,
            thickness: 2,
          ),
          const SizedBox(height: 18),
          if (context.width <= 700)
            Image.asset(
              'assets/img/unifei-logo.png',
              height: 150,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (context.width > 700)
                Image.asset(
                  'assets/img/unifei-logo.png',
                  height: 150,
                ),
              if (context.width > 500)
                listDados(
                  'Desenvolvedores',
                  ['Jackson Silveira', 'Lucas Seraggi', 'Paulo Paiva'],
                  context,
                ),
              listDados(
                'Contatos',
                ['jacksongdas.jackson@gmail.com', 'lucas.seraggi@hotmail.com', 'paulojr.eco@gmail.com'],
                context,
              ),
              listSocial(
                ['github.com/JacksonECO', 'github.com/LucasSeraggi', 'github.com/paulojr-eco'],
                [
                  'linkedin.com/in/jackson-silveira/',
                  'linkedin.com/in/lucas-fernandes-seraggi-296111206',
                  'linkedin.com/in/paulojr-eco/',
                ],
                context,
              ),
            ],
          ),
          const SizedBox(height: 22),
          Divider(
            color: context.colors.grayDark,
            thickness: 2,
          ),
          const SizedBox(height: 18),
          SelectableText(
            'Todos os Direitos Reservados © 2023',
            style: context.style.interRegular.copyWith(fontSize: 18, color: Colors.white),
          ),
        ]),
      ),
    );
  }

  Widget listDados(String title, List<String> info, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          title,
          style: context.style.interRegular.copyWith(fontSize: 16, color: context.colors.greenBlue),
        ),
        const SizedBox(height: 8),
        ...info
            .map((text) => Click(
                  onTap: info.first.contains('@')
                      ? () {
                          launchUrl(Uri(
                            scheme: 'mailto',
                            path: text,
                          ));
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      text,
                      style: context.style.interRegular.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget listSocial(List<String> git, List<String> linkedIn, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Social',
          style: context.style.interRegular.copyWith(fontSize: 16, color: context.colors.greenBlue),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Column(
              children: git
                  .map(
                    (link) => Click(
                      onTap: () {
                        launchUrl(Uri(
                          scheme: 'https',
                          path: link,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.asset('assets/icon/gitHub-logo.png', height: 30),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(width: 12),
            Column(
              children: linkedIn
                  .map(
                    (link) => Click(
                      onTap: () {
                        launchUrl(Uri(
                          scheme: 'https',
                          path: link,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.asset('assets/icon/linkedIn-logo.png', height: 30),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ],
    );
  }
}

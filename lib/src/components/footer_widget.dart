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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), //h24 w32
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Trabalho FINAL de Graduação'.toUpperCase(),
            style: context.style.poppinsBlack.copyWith(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Este trabalho foi feito com muito amor...',
            style: context.style.interRegular.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 22),
          Divider(
            color: context.colors.grayDark,
            thickness: 2,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/img/unifei-logo.png',
                height: 150,
              ),
              listDados(
                'Desenvolvedores',
                ['Jackson Galdino', 'Lucas Seraggi', 'Paulo Paiva'],
                context,
              ),
              listDados(
                'Contatos',
                [
                  'jacksongdas.jackson@gmail.com',
                  'lucas.seraggi@hotmail.com',
                  'paulojr.eco@gmail.com'
                ],
                context,
              ),
              listSocial(
                ['github.com/JacksonECO', 'github.com/LucasSeraggi', 'github.com/paulojr-eco'],
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
          Text(
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
        Text(
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

  Widget listSocial(List<String> urls, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social',
          style: context.style.interRegular.copyWith(fontSize: 16, color: context.colors.greenBlue),
        ),
        const SizedBox(height: 8),
        ...urls
            .map((link) => Click(
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
                ))
            .toList(),
      ],
    );
  }
}

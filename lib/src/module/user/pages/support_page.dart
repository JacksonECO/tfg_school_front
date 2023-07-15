import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/module/user/controller/support_controller.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late final SupportController controller;

  @override
  void initState() {
    super.initState();
    controller = Modular.get<SupportController>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        FutureBuilder<bool>(
          future: controller.future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: SelectableText(
                  'Não foi carregar a página',
                  style: context.style.poppinsMedium,
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: SelectableText(
                        'Carregando...',
                        style: context.style.poppinsMedium,
                      ),
                    ),
                  ],
                ),
              );
            }
            return CrudViewer(title: 'Suporte', body: [
              SelectableText(
                'Entre em Contato Conosco',
                textAlign: TextAlign.center,
                style: context.style.poppinsRegular.copyWith(
                  fontSize: 30,
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 20,
                thickness: 3,
              ),
              const SizedBox(height: 12),
              SelectableText(
                'Para obter suporte entre com contato por algum dos seguintes canais:',
                style: context.style.poppinsLight.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 60,
                children: [
                  card(
                    title: 'Email',
                    description: controller.email,
                    color: context.colors.greenBlue,
                    // onTap: () {
                    // launchUrl(Uri(
                    //   scheme: 'mailto',
                    //   path: controller.email,
                    // ));
                    // },
                  ),
                  card(
                    title: 'Telefone',
                    description: controller.phone,
                    color: const Color(0xFF0063F8),
                    // onTap: () {
                    // launchUrl(Uri(
                    //   scheme: 'tel',
                    //   path: controller.phone,
                    // ));
                    // },
                  ),
                ],
              )
            ]);
          },
        ),
      ],
    );
  }

  Widget card({
    required String title,
    required String description,
    required Color color,
  }) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 274,
          height: 122,
          decoration: ShapeDecoration(
            color: CustomColors.i.backgroundPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0xFF000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: SelectableText(
              description,
              style: context.style.poppinsRegular.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: 214,
          height: 47,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Center(
            child: SelectableText(
              title,
              style: context.style.poppinsBold.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

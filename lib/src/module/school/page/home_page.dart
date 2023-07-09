import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_widget.dart';

class HomePage extends StatelessWidget {
  final ProfileController controllerProfile;
  const HomePage({super.key, required this.controllerProfile});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        FutureBuilder<bool>(
            future: controllerProfile.getSchool,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SelectableText('Não foi possível carregar os dados da escola');
              }
              if (!snapshot.hasData) {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              }

              return ProfileWidget(controller: controllerProfile);
            }),
      ],
    );
  }
}

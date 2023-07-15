import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';

class HomePageDev extends StatefulWidget {
  const HomePageDev({super.key});

  @override
  State<HomePageDev> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectableText(
          'Acho que deveria ser uma tela de apresentação do sistema, com marketing de venda',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(Modular.get<AuthModel>().toJson()),
            ElevatedButton(
              child: const SelectableText('User'),
              onPressed: () => Navigator.pushNamed(context, UserModule.initialRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const SelectableText('School'),
              onPressed: () => Navigator.pushNamed(context, SchoolModule.initialRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const SelectableText('Login School'),
              onPressed: () => Navigator.pushNamed(context, HomeModule.loginSchoolRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const SelectableText('Login User'),
              onPressed: () => Navigator.pushNamed(context, HomeModule.loginUserRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const SelectableText('EasyLoading'),
              onPressed: () {
                EasyLoading.show();
                Future.delayed(const Duration(seconds: 5), () {
                  EasyLoading.dismiss();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Acho que deveria ser uma tela de apresentação do sistema, com marketing de venda',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Modular.get<AuthModel>().toJson()),
            ElevatedButton(
              child: const Text('User'),
              onPressed: () => Navigator.pushNamed(context, UserModule.initialRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const Text('School'),
              onPressed: () => Navigator.pushNamed(context, SchoolModule.initialRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const Text('Login School'),
              onPressed: () => Navigator.pushNamed(context, HomeModule.loginSchoolRoute),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              child: const Text('Login User'),
              onPressed: () => Navigator.pushNamed(context, HomeModule.loginUserRoute),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

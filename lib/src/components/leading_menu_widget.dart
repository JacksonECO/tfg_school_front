import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/school/school_module.dart';

class LeadingMenuWidget extends StatelessWidget {
  LeadingMenuWidget({super.key});

  final user = Modular.get<AuthModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      constraints: BoxConstraints(
        minHeight: context.size2.height - 90,
      ),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        border: const Border(
          right: BorderSide(color: Colors.black, width: 3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              if (user.photoUrl != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.network(user.photoUrl!, height: 100),
                  ),
                ),
              Text(user.name!),
              const SizedBox(height: 6),
              const Divider(height: 0),
              ExpansionTile(
                title: const Text('Alunos'),
                children: [
                  ListTile(
                    title: const Text('Matricular Aluno'),
                    onTap: () {
                      Modular.to.pushNamed(SchoolModule.studentRoute);
                    },
                  ),
                  const ListTile(title: Text('Listar Alunos')),
                ],
              ),
              const ExpansionTile(
                title: Text('Funcionário'),
                children: [
                  ListTile(title: Text('Adicionar Funcionário')),
                  ListTile(title: Text('Listar Funcionários')),
                ],
              ),
              const ExpansionTile(
                title: Text('Cursos'),
                children: [
                  ListTile(title: Text('Criar Curso')),
                  ListTile(title: Text('Listar Curso')),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Suporte'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuração'),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

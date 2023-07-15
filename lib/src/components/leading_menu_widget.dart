import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/auth_model.dart';

class LeadingMenuWidget extends StatefulWidget {
  const LeadingMenuWidget({super.key});

  static bool isClose = false;

  @override
  State<LeadingMenuWidget> createState() => _LeadingMenuWidgetState();
}

class _LeadingMenuWidgetState extends State<LeadingMenuWidget> {
  final user = Modular.get<AuthModel>();
  late final LeadingMenu leadingMenu;
  bool get isClose => LeadingMenuWidget.isClose;

  @override
  void initState() {
    leadingMenu = user.leadingMenuObjectList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.height),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: isClose ? 100 : 250,
                color: context.colors.navBar,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ...leadingMenu.top.map((e) => tile(e)),
                    const Spacer(),
                    ...leadingMenu.bottom.map((e) => tile(e)),
                  ],
                ),
              ),
              Container(
                width: 15,
                color: Colors.transparent,
              )
            ],
          ),
          Positioned(
            top: 26,
            right: 0,
            child: Click(
              child: CircleAvatar(
                radius: 15,
                backgroundColor: context.colors.primary,
                child: Image.asset(
                  isClose ? 'assets/icon/double-right-arrows.png' : 'assets/icon/double-left-arrows.png',
                  height: 9,
                  width: 9,
                ),
              ),
              onTap: () {
                setState(() {
                  LeadingMenuWidget.isClose = !isClose;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget tile(LeadingMenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: item.canSelect
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: context.colors.primary.withOpacity(0.5),
                padding: item.canSelect ? const EdgeInsets.symmetric(vertical: 16, horizontal: 14) : EdgeInsets.zero,
                backgroundColor:
                    Modular.args.uri.path == item.route ? context.colors.primary.withOpacity(0.7) : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: isClose ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  item.icon,
                  if (!isClose) const SizedBox(width: 14),
                  if (!isClose)
                    SelectableText(
                      item.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                ],
              ),
              onPressed: () {
                if (item.onTap != null) {
                  item.onTap!();
                  return;
                }
                if (item.route != null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(item.route!, (route) => false);
                }
              },
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                mainAxisAlignment: isClose ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  item.icon,
                  if (!isClose) const SizedBox(width: 14),
                  if (!isClose)
                    SelectableText(
                      item.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
    );
  }
}

class LeadingMenuItem {
  final String title;
  final String? subTitle;
  final String? route;
  final Function? onTap;
  final Widget icon;
  final bool canSelect;

  const LeadingMenuItem({
    required this.title,
    required this.icon,
    this.canSelect = true,
    this.route,
    this.onTap,
    this.subTitle,
  });
}

class LeadingMenu {
  final List<LeadingMenuItem> top = [];
  final List<LeadingMenuItem> bottom = [];
}

// @override
// Widget build(BuildContext context) {
//   return Stack(
//     children: [
//       Positioned(child: Icon(Icons.menu, size: 50), top: 10, left: 10),
//       Container(
//         width: 300,
//         constraints: BoxConstraints(
//           minHeight: context.height - 90,
//         ),
//         decoration: BoxDecoration(
//           color: context.colors.secondary,
//           border: const Border(
//             right: BorderSide(color: Colors.black, width: 3),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: (user.photoUrl != null)
//                         ? Image.network(user.photoUrl!, height: 100)
//                         : const Icon(Icons.person, size: 100),
//                   ),
//                 ),
//                 SelectableText(user.name ?? ''),
//                 const SizedBox(height: 6),
//                 const Divider(height: 0),
//                 ExpansionTile(
//                   title: const SelectableText('Alunos'),
//                   children: [
//                     ListTile(
//                       title: const SelectableText('Matricular Aluno'),
//                       onTap: () {
//                         Modular.to.pushNamed(SchoolModule.studentRoute);
//                       },
//                     ),
//                     ListTile(
//                       title: const SelectableText('Listar Alunos'),
//                       onTap: () {
//                         Modular.to.pushNamed(SchoolModule.listStudentsRoute);
//                       },
//                     ),
//                   ],
//                 ),
//                 const ExpansionTile(
//                   title: SelectableText('Funcionário'),
//                   children: [
//                     ListTile(title: SelectableText('Adicionar Funcionário')),
//                     ListTile(title: SelectableText('Listar Funcionários')),
//                   ],
//                 ),
//                 const ExpansionTile(
//                   title: SelectableText('Cursos'),
//                   children: [
//                     ListTile(title: SelectableText('Criar Curso')),
//                     ListTile(title: SelectableText('Listar Curso')),
//                   ],
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 const SizedBox(height: 50),
//                 ListTile(
//                   leading: const Icon(Icons.support_agent),
//                   title: const SelectableText('Suporte'),
//                   onTap: () {},
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const SelectableText('Configuração'),
//                   onTap: () {},
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ],
//   );
// }

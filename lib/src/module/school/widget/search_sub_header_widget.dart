import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/widget/profile_user_widget.dart';

class SearchSubHeaderWidget extends StatefulWidget {
  final void Function(String value) onChanged;
  final AuthRoleEnum typeUser;

  final Function({required bool isStudent, int? userId})
      profileUserControllerType;

  const SearchSubHeaderWidget({
    required this.onChanged,
    required this.typeUser,
    required this.profileUserControllerType,
    super.key,
  });

  @override
  State<SearchSubHeaderWidget> createState() => _SearchSubHeaderWidgetState();
}

class _SearchSubHeaderWidgetState extends State<SearchSubHeaderWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Procurar ${widget.typeUser == AuthRoleEnum.student ? 'Alunos' : 'Professores'}',
                        style: context.style.interSemiBold
                            .copyWith(letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.search),
                          ),
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border,
                          errorBorder: border,
                          focusedErrorBorder: border,
                          disabledBorder: border,
                          hintText: 'Pesquisar',
                          fillColor: context.colors.gray,
                          filled: true,
                          hintStyle: context.style.interLight,
                        ),
                        style: context.style.interRegular,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Button.blue(
                  text: 'Buscar',
                  onPressed: () {
                    widget.onChanged(controller.text);
                  },
                  width: 110,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 50),
        Button.green(
          text:
              'Adicionar ${widget.typeUser == AuthRoleEnum.student ? 'Aluno' : 'Professor'}',
          onPressed: () {
            ProfileUserWidget.showModal(
              profileUserController: widget.profileUserControllerType(
                isStudent: widget.typeUser == AuthRoleEnum.student,
              ),
            );
          },
          width: 200,
        ),
      ],
    );
  }

  OutlineInputBorder get border =>
      ThemeConfig.border.copyWith(borderRadius: BorderRadius.circular(8));
}

import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';

class SearchSubHeaderWidget extends StatefulWidget {
  final String title;
  final void Function(String value)? onChanged;
  final void Function() onAdd;

  const SearchSubHeaderWidget({
    required this.onAdd,
    required this.title,
    this.onChanged,
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
          child: widget.onChanged == null
              ? Container()
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 550),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Procurar ${widget.title}',
                              style: context.style.interSemiBold.copyWith(letterSpacing: 0.5),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: controller,
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
                        onPressed: () => widget.onChanged!(controller.text),
                        width: 110,
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(width: 50),
        Button.green(
          text: 'Adicionar ${widget.title}',
          onPressed: widget.onAdd,
          width: 200,
        ),
      ],
    );
  }

  OutlineInputBorder get border =>
      ThemeConfig.border.copyWith(borderRadius: BorderRadius.circular(8));
}

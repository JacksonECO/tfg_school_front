import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';

class Button extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool withRadius;
  final double borderRadius;
  final bool withBorder;
  final double height;
  final double? width;
  final TextStyle? textStyles;
  final Widget? prefixIcon;

  const Button({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.height,
    this.width,
    this.textStyles,
    this.withRadius = true,
    this.withBorder = true,
    this.borderRadius = 10,
    this.prefixIcon,
    super.key,
  });

  factory Button.blue({
    required String text,
    required Function onPressed,
    double width = double.infinity,
  }) {
    return Button(
      text: text,
      onPressed: onPressed,
      color: CustomColors.i.blue,
      withBorder: false,
      height: 46,
      width: width,
      borderRadius: 8,
    );
  }

  factory Button.green({
    required String text,
    required Function onPressed,
    double width = double.infinity,
  }) {
    return Button(
      text: text,
      onPressed: onPressed,
      color: CustomColors.i.green,
      withBorder: false,
      height: 46,
      width: width,
      borderRadius: 8,
    );
  }

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          // await Future.delayed(const Duration(milliseconds: 50000), () {});
          await widget.onPressed();
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius:
                widget.withRadius ? BorderRadius.circular(widget.borderRadius) : BorderRadius.zero,
            side: widget.withBorder
                ? const BorderSide(color: Colors.black, width: 1)
                : BorderSide.none,
          ),
          elevation: 5,
          surfaceTintColor: Colors.white,
        ),
        child: _isLoading
            ? SizedBox.square(
                dimension: min<double>(widget.height, widget.width ?? double.infinity) - 15,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
                ),
              )
            : (widget.prefixIcon == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        widget.text,
                        style: widget.textStyles ?? context.style.button,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.prefixIcon!,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            widget.text,
                            style: widget.textStyles ?? context.style.button,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/menu_floating_item.dart';

class FloatingMenu {
  static List<MenuFloatingItem> listOptions = [];

  static Future showFloatingMenu() {
    return showDialog(
      context: Constants.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.bottomRight,
          insetPadding: const EdgeInsets.fromLTRB(0, 0, 20, 80),
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200, minHeight: 60),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: listOptions.map((item) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          item.handleShow();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Row(
                            children: [
                              Image.asset(
                                item.iconPath,
                                height: 24,
                                width: 24,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                item.title,
                                style: context.style.poppinsMedium.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

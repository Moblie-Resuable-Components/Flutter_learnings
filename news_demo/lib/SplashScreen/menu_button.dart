import 'package:flutter/material.dart';

import '../main.dart';

class MenuButton extends StatelessWidget {
  final Function onTap;
  final String label;
  const MenuButton({
    @required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isLightTheme = true;
    return GestureDetector(
      key: Key("login_button"),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        decoration: BoxDecoration(
            color: Color(0xFFE1295E),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

Widget inputForm(
  String? Function(String?)? validator, {
  required TextEditingController controller,
  required String hintTxt,
  required IconData iconData,
  bool obscureText = false,
  bool isVisible = false,
  VoidCallback? onToggleVisibility,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obscureText ? !isVisible : false,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintTxt,
      prefixIcon: Icon(iconData),
      suffixIcon: obscureText
          ? IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onToggleVisibility,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    ),
  );
}

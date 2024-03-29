import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool ispass;
  final TextInputType textInputType;

  const TextFieldInput(
      {Key?key, required this.textEditingController, required this.hintText, this.ispass=false, required this.textInputType})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context)
    );
    return TextField(
      controller:textEditingController,
      decoration: InputDecoration(
        hintText:hintText,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType:textInputType,
      obscureText:ispass,

    );
  }
}

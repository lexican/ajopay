import 'package:flutter/material.dart';

class PasswordInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obsecureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String label;
  final String hintText;
  final Function setObscureText;

  const PasswordInputTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecureText = true,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.label = "",
      required this.hintText,
      required this.setObscureText,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: TextFormField(
            autofocus: autofocus,
            minLines: isMulti ? 4 : 1,
            maxLines: isMulti ? null : 1,
            enabled: enabled,
            readOnly: readOnly,
            obscureText: obsecureText,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              focusedBorder:
                  Theme.of(context).inputDecorationTheme.focusedBorder,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  !obsecureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setObscureText();
                },
              ),
            ),
            validator: validator));
  }
}

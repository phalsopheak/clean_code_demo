import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final int maxLength;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onKeyReturn;
  final TextInputAction textInputAction;
  final bool isReadOnly;
  final bool isEnabled;

  const TextBox({
    Key? key,
    this.label = 'tec1',
    this.maxLength = 50,
    this.controller,
    this.focusNode,
    this.onKeyReturn,
    this.textInputAction = TextInputAction.done,
    this.isReadOnly = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        readOnly: isReadOnly,
        enabled: isEnabled,
        textInputAction: textInputAction,
        onSubmitted: (x) {
          onKeyReturn!();
        },
        focusNode: focusNode,
        maxLength: maxLength,
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: '',
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nullshop/main.dart';

void showSnackBar(String? text, {Color? backgroundColor}) {
  if (text == null) return;

  final snackBar = SnackBar(
    content: Text(
      text,
      selectionColor: Colors.white,
    ),
    backgroundColor: backgroundColor ?? Colors.red,
  );

  // messageKey.currentState!.removeCurrentSnackBar();
  // messageKey.currentState!.showSnackBar(snackBar);
  // VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
  messageKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

import 'package:flutter/material.dart';
import 'package:nullshop/themes/colors.dart';

InputDecoration inputDecorationWidget(context, labelText) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsGrey),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kColorsGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kColorsPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kColorsRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kColorsRed, width: 2),
      ),
      errorStyle: Theme.of(context).textTheme.bodyText1);
}

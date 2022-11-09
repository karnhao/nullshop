import 'package:nullshop/themes/colors.dart';
import 'package:flutter/material.dart';

class CoinBtnWidget extends StatelessWidget {
  final String textBtn;
  const CoinBtnWidget({Key? key, required this.textBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 81,
      decoration: const BoxDecoration(
        color: kColorsRed,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          textBtn,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsWhite),
        ),
      ),
    );
  }
}

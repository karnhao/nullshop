import 'package:nullshop/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinMenuWidget extends StatelessWidget {
  final String iconBtn;
  final String textBtn;
  const CoinMenuWidget({Key? key, required this.iconBtn, required this.textBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(iconBtn, color: kColorsPurple),
        const SizedBox(height: 7),
        Text(textBtn,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: kColorsPurple))
      ],
    );
  }
}

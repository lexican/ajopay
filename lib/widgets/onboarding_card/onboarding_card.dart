import 'package:ajopay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingCard extends StatelessWidget {
  final String title;
  final String description;
  final String assetImage;
  const OnBoardingCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(assetImage),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: baseBlack, fontSize: 32, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: baseBlackLight, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

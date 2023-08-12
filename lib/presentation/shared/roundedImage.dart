import 'package:flutter/material.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.imageUrl});

  final double screenWidth;
  final double screenHeight;
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth * 0.2,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lightGreyColor,
      ),
      child: Image.asset(imageUrl),
    );
  }
}

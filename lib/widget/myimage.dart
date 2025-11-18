import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imagePath;

  const MyImage({
    super.key,
    this.width,
    this.height,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imagePath',
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey,
          child: const Icon(Icons.image, color: Colors.white),
        );
      },
    );
  }
}

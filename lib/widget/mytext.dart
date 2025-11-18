import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final Color color;
  final String text;
  final TextAlign textalign;
  final double fontsizeNormal;
  final bool multilanguage;
  final bool inter;
  final int maxline;
  final FontWeight fontwaight;
  final TextOverflow overflow;
  final FontStyle fontstyle;

  const MyText({
    super.key,
    required this.color,
    required this.text,
    required this.textalign,
    required this.fontsizeNormal,
    required this.multilanguage,
    required this.inter,
    required this.maxline,
    required this.fontwaight,
    required this.overflow,
    required this.fontstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textalign,
      maxLines: maxline,
      overflow: overflow,
      style: GoogleFonts.roboto(
        fontSize: fontsizeNormal,
        color: color,
        fontWeight: fontwaight,
        fontStyle: fontstyle,
      ),
    );
  }
}

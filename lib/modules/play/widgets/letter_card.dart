import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    required this.text,
    required this.backgroundColor,
    required this.color,
    Key? key,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 200),
        width: text == null ? 16 : null,
        height: text == null ? 16 : null,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(text == null ? 32 : 8),
          ),
        ),
        child: Center(
          child: Text(
            text?.toUpperCase() ?? '',
            style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

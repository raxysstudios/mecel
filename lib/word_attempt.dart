import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordAttempt extends StatelessWidget {
  const WordAttempt({
    required this.length,
    required this.text,
    this.check,
    Key? key,
  }) : super(key: key);

  final String? check;
  final int length;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          for (var i = 0; i < length; i++)
            Expanded(
              child: Builder(builder: (context) {
                final char = i < text.length ? text[i] : '';
                Color? color;
                if (check != null && char.isNotEmpty) {
                  final j = check?.indexOf(char);
                  color = j == -1
                      ? Colors.blueGrey.shade400
                      : j == i
                          ? Colors.green.shade400
                          : Colors.amber.shade400;
                }
                return Card(
                  color: color,
                  elevation: 0,
                  child: Center(
                    child: Builder(builder: (context) {
                      return Text(
                        char.toUpperCase(),
                        style: GoogleFonts.firaMono(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: color == null ? null : Colors.white),
                      );
                    }),
                  ),
                );
              }),
            )
        ],
      ),
    );
  }
}

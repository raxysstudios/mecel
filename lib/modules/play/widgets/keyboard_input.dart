import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/input_key.dart';

class KeyboardInput extends StatelessWidget {
  const KeyboardInput({
    required this.layout,
    required this.textCallback,
    this.rowHeight = 48,
    Key? key,
  }) : super(key: key);

  final double rowHeight;
  final InputLayout layout;
  final ValueSetter<String> textCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in layout)
          SizedBox(
            height: rowHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final key in row)
                  Builder(
                    builder: (context) {
                      final card = Card(
                        margin: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: key.callback ??
                              () => textCallback(key.text ?? ''),
                          child: Center(
                            child: key.text == null
                                ? Icon(key.icon)
                                : Text(
                                    key.text!.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      );
                      return Expanded(
                        flex: key.flex,
                        child: card,
                      );
                    },
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

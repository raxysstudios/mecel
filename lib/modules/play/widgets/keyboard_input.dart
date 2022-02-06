import 'package:flutter/material.dart';

import '../../../shared/models/input_key.dart';

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
    return Card(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          for (final row in layout)
            SizedBox(
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final key in row)
                    Expanded(
                      flex: key.flex,
                      child: InkResponse(
                        onTap:
                            key.callback ?? () => textCallback(key.text ?? ''),
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
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

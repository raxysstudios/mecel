import 'package:flutter/material.dart';

enum LetterState { missing, shifted, present }

class LetterCard extends StatelessWidget {
  const LetterCard({
    this.text,
    this.state,
    Key? key,
  }) : super(key: key);

  final String? text;
  final LetterState? state;

  Color? getBackgroundColor(Color? defaultColor) {
    switch (state) {
      case LetterState.missing:
        return Colors.blueGrey.shade400;
      case LetterState.shifted:
        return Colors.amber.shade400;
      case LetterState.present:
        return Colors.green.shade400;
      default:
        return defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorSceme = Theme.of(context).colorScheme;

    return Flexible(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 200),
        width: text == null ? 16 : null,
        height: text == null ? 16 : null,
        decoration: BoxDecoration(
          color: getBackgroundColor(colorSceme.surface),
          borderRadius: BorderRadius.all(
            Radius.circular(text == null ? 32 : 4),
          ),
        ),
        child: Center(
          child: Text(
            text?.toUpperCase() ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: state == null ? null : colorSceme.surface,
            ),
          ),
        ),
      ),
    );
  }
}

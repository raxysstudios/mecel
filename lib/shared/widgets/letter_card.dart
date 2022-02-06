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

  Color? getBackgroundColor(bool isDark, [Color? defaultColor]) {
    final shade = isDark ? 600 : 400;
    switch (state) {
      case LetterState.missing:
        return Colors.blueGrey[shade];
      case LetterState.shifted:
        return Colors.amber[shade];
      case LetterState.present:
        return Colors.green[shade];
      default:
        return defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Flexible(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 200),
        width: text == null ? 16 : null,
        height: text == null ? 16 : null,
        decoration: BoxDecoration(
          color: getBackgroundColor(
            theme.brightness == Brightness.dark,
            theme.colorScheme.surface,
          ),
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
              color: state == null ? null : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

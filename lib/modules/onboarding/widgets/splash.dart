import 'package:flutter/material.dart';
import 'package:wordle/shared/widgets/raxys.dart';

class Splash extends StatelessWidget {
  const Splash(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RaxysLogo(size: 256),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Made with honor in'),
            const Text(
              'North Caucasus',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

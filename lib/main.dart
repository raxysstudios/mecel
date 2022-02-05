import 'package:flutter/material.dart';
import 'package:wordle/config/keyboard_layouts.dart';
import 'package:wordle/keyboard_input.dart';
import 'package:wordle/word_attempt.dart';

import 'config/themes.dart';
import 'input_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themes = Themes(colorScheme);
    return MaterialApp(
      title: 'Wordle',
      theme: themes.light,
      darkTheme: themes.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final maxRows = 5;
  final currentAttempt = 2;
  var text = "";

  late InputLayout layout;

  @override
  void initState() {
    super.initState();
    layout = lezgi_layout
        .map((w) => w.characters.map((c) => InputKey(c)).toList())
        .toList();
    layout.last = [
      InputKey(
        null,
        flex: 2,
        icon: Icons.check_rounded,
        callback: () {},
      ),
      ...layout.last,
      InputKey(
        null,
        flex: 2,
        icon: Icons.backspace_outlined,
        callback: () {
          if (text.isNotEmpty) {
            setState(() {
              text = text.substring(0, text.length - 1);
            });
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WordAttempt(
            length: 5,
            text: text,
            check: 'лезги',
          ),
          KeyboardInput(
            layout: layout,
            textCallback: (c) => setState(() {
              text += c;
            }),
          ),
        ],
      ),
    );
  }
}

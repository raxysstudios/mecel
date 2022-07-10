import 'package:flutter/material.dart';
import 'package:mecel/shared/extensions.dart';
import 'package:mecel/shared/widgets/letter_card.dart';
import 'package:mecel/shared/widgets/raxys.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  Widget buildExample(
    BuildContext context,
    String word,
    int letter,
    LetterState state,
    String caption,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              for (var i = 0; i < word.length; i++)
                LetterCard(
                  text: word[i],
                  state: i == letter ? state : null,
                ),
            ],
          ),
        ),
        ListTile(
          dense: true,
          leading: const SizedBox(),
          title: Text(caption),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Raxys(scale: 3),
        title: Text(context.lclz('howTo')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(context.lclz('play')),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const Icon(Icons.auto_awesome_rounded),
            title: Text(context.lclz('guesses')),
          ),
          ListTile(
            leading: const Icon(Icons.spellcheck_rounded),
            title: Text(context.lclz('letters')),
          ),
          ListTile(
            leading: const Icon(Icons.palette_rounded),
            title: Text(context.lclz('colors')),
          ),
          ListTile(
            leading: const Icon(Icons.today_rounded),
            title: Text(context.lclz('daily')),
          ),
          ListTile(
            leading: const Icon(Icons.rule_rounded),
            title: Text(
              context.lclz('examples'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (var i = 1; i <= 3; i++)
            buildExample(
              context,
              context.lclz('e${i}Word'),
              (i - 1) * 2,
              LetterState.values[3 - i],
              context.lclz('e${i}Caption'),
            ),
        ],
      ),
    );
  }
}

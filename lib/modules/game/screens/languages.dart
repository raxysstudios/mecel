
import 'package:flutter/material.dart';
import 'package:wordle/shared/extensions.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/services/language_assets.dart';
import 'package:wordle/shared/widgets/language_avatar.dart';
import 'package:wordle/shared/widgets/rounded_back_button.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({
    this.canSkip = true,
    Key? key,
  }) : super(key: key);

  final bool canSkip;

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<Language>? languages;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadLanguages(sort: true).then(
      (l) => setState(() {
        languages = l;
      }),
    );
  }

  List<Language> filterLanguages() {
    final text = textController.text;
    return languages!
        .where((l) => l.name.contains(text) || l.nativeName.contains(text))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: widget.canSkip ? const RoundedBackButton() : null,
        title: TextField(
          controller: textController,
        ),
        actions: [
          if (textController.text.isNotEmpty)
            IconButton(
              onPressed: () => textController.clear(),
              icon: const Icon(Icons.clear_rounded),
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: Builder(builder: (context) {
        if (this.languages == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final languages = filterLanguages();
        return ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, i) {
            final l = languages[i];
            return ListTile(
              leading: LanguageAvatar(l),
              title: Text(l.name.titleCase),
              subtitle: Text(l.nativeName.titleCase),
              onTap: () => Navigator.pop(context, l),
            );
          },
        );
      }),
    );
  }
}

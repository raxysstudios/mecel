import 'package:flutter/material.dart';
import 'package:wordle/modules/language/services/assets_service.dart';
import 'package:wordle/shared/extensions.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/widgets/language_avatar.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<Language>? languages;

  @override
  void initState() {
    super.initState();
    loadLanguages(sort: true).then(
      (l) => setState(() {
        languages = l;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: Builder(
        builder: (context) {
          if (languages == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox.square(
                  dimension: 32,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: languages!.length,
            itemBuilder: (context, i) {
              final l = languages![i];
              return ListTile(
                leading: LanguageAvatar(l),
                title: Text(l.name.titleCase),
                subtitle: Text(l.nativeName.titleCase),
                onTap: () => Navigator.pop(context, l),
              );
            },
          );
        },
      ),
    );
  }
}

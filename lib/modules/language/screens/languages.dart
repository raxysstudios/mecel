import 'package:flutter/material.dart';
import 'package:mecel/models/language.dart';
import 'package:mecel/modules/language/services/assets_service.dart';
import 'package:mecel/shared/extensions.dart';
import 'package:mecel/shared/widgets/language_avatar.dart';
import 'package:mecel/shared/widgets/rounded_back_button.dart';

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
        leading: const RoundedBackButton(),
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

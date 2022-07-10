import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mecel/config/dark_theme.dart';
import 'package:mecel/config/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/game/screens/help.dart';
import 'modules/game/services/config_service.dart';
import 'modules/language/services/language_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lightTheme = getLightTheme(colorScheme);
    final darkTheme = getDarkTheme(colorScheme);
    return MaterialApp(
      title: 'Mecel',
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(
          lightTheme.textTheme,
        ),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(
          darkTheme.textTheme,
        ),
      ),
      home: FutureBuilder<String?>(
        future: SharedPreferences.getInstance()
            .then((p) => p.getString('language')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) async {
                var language = snapshot.data;
                final first = language == null;
                language ??= await changeLanguage(context, false);
                final config = await loadConfig(language);
                if (first) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => Provider.value(
                        value: config.localization,
                        builder: (context, _) => const HelpScreen(),
                      ),
                    ),
                  );
                }
                startGame(context, config);
              },
            );
          }
          return const Material();
        },
      ),
    );
  }
}

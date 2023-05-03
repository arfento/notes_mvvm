import 'package:flutter/material.dart';
import 'package:notes_mvvm/presentation/pages/add_edit_note_page.dart';
import 'package:notes_mvvm/presentation/pages/home_page.dart';
import 'package:notes_mvvm/presentation/pages/language_page.dart';
import 'package:notes_mvvm/presentation/pages/settings_page.dart';
import 'package:notes_mvvm/splash_screen.dart';

class RoutePaths {
  static const coreSplash = '/';
  static const home = '/home';
  static const addEditNote = '/add_edit_note';
  static const settings = '/settings';
  static const settingsLanguage = '/settings/language';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Core
      case RoutePaths.coreSplash:
        return MaterialPageRoute(builder: (_) => const Splash());

      //Settings
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case RoutePaths.settingsLanguage:
        return MaterialPageRoute(builder: (_) => const LanguagePage());

      //Home
      case RoutePaths.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(seconds: 1),
        );
      case RoutePaths.addEditNote:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => AddEditNote(visualNoteModel: args['visualNoteModel']),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}

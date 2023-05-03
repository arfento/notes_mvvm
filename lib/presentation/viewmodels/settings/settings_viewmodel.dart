// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/init_services/theme_service.dart';

final settingsViewModel =
    ChangeNotifierProvider<SettingsViewModel>((ref) => SettingsViewModel());

class SettingsViewModel extends ChangeNotifier {
  late String selectedLanguageCode;
  late bool isLightThemeMode;

  SettingsViewModel() {
    selectedLanguageCode = AppLocalizations.instance.getLanguageCode();
    isLightThemeMode = !Get.isDarkMode;
  }

  changeLocale({required String langCode}) {
    selectedLanguageCode = langCode;
    AppLocalizations.instance.changeLocale(languageCode: langCode);
    notifyListeners();
  }

  changeTheme({required bool isLight}) {
    ThemeService.instance.changeTheme(
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
    );
    isLightThemeMode = !isLightThemeMode;
    notifyListeners();
  }
}

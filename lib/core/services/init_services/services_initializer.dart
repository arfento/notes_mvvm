import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/init_services/theme_service.dart';
import 'package:notes_mvvm/core/styles/app_images.dart';

class ServiceInitializer {
  ServiceInitializer._();

  static final ServiceInitializer instance = ServiceInitializer._();

  initializeSettings() async {
    //This method is used to initialize any service before the app runs (in main method)
    initializeGetNavigationKey();
    List futures = [
      initializeLocalization(),
      initializeTheme(),
      //initializeScreensOrientation(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  initializeGetNavigationKey() {
    Get.addKey(NavigationService.navigationKey);
  }

  initializeLocalization() async {
    return await AppLocalizations.instance.getUserStoredLocale();
  }

  initializeTheme() async {
    return await ThemeService.instance.getUserStoredTheme();
  }

  initializeScreensOrientation() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  }

  Future initializeData() async {
    List futures = [
      cacheDefaultImages(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  cacheDefaultImages() async {
    precacheImage(
        const AssetImage(AppImages.appLogoIcon), NavigationService.context);
    precacheImage(
        const AssetImage(AppImages.splash), NavigationService.context);
  }
}

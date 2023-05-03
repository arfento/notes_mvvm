import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/config/router/routes.dart';
import 'package:notes_mvvm/core/services/init_services/services_initializer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModel = ChangeNotifierProvider.autoDispose<SplashViewModel>(
    (ref) => SplashViewModel());

class SplashViewModel extends ChangeNotifier {
  late String secondPage;
  SplashViewModel() {
    initializeData().then(
      (_) {
        NavigationService.offAll(
          isNamed: true,
          page: secondPage,
        );
      },
    );
  }

  Future initializeData() async {
    await Future.delayed(const Duration(seconds: 2), () {});

    List futures = [
      ServiceInitializer.instance.initializeData(),
      goToSecondPagePage(),
    ];
    await Future.wait<dynamic>([...futures]);
  }

  Future goToSecondPagePage() async {
    secondPage = RoutePaths.home;
  }
}

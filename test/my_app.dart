import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/config/router/routes.dart';
import 'package:notes_mvvm/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(414, 895)
              : const Size(895, 414),
          minTextAdapt: true,
          builder: (context, child) {
            return GetMaterialApp(
              builder: (context, widget) {
                ScreenUtil.init(context);
                return widget!;
              },
              home: const HomePage(),
              onGenerateRoute: AppRouter.generateRoute,
            );
          });
    });
  }
}

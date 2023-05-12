import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'presentation/widgets/custom_widgets/custom_app_bar_widget.dart';

class PopUpPage extends StatelessWidget {
  final Widget child;
  final bool appBarSkippable;
  final bool appBarWithMenu;
  final bool appBarWithBack;
  final Function? skipBehaviour;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool showBackgroundImage;
  final bool fixedNavigationBarColor;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? backButtonWidget;
  final double? appbarHeight;
  final List<Widget> appbarItems;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final dynamic result;
  final Future<bool> Function()? onWillPop;
  final Color? appBarColor;
  final Color? backButtonColor;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final bool showUpperShadow;

  const PopUpPage({
    Key? key,
    this.child = const SizedBox(),
    this.appBarSkippable = false,
    this.appBarWithMenu = false,
    this.appBarWithBack = false,
    this.showBackgroundImage = false,
    this.skipBehaviour,
    this.scaffoldKey,
    this.fixedNavigationBarColor = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = false,
    this.appbarHeight,
    this.appbarItems = const [],
    this.drawer,
    this.floatingActionButton,
    this.onWillPop,
    this.result,
    this.appBarColor,
    this.backButtonColor,
    this.backButtonWidget,
    this.safeAreaTop,
    this.showUpperShadow = false,
    this.safeAreaBottom,
  })  : assert((appBarSkippable ^ (skipBehaviour == null)) &&
            (appBarWithMenu ^ (scaffoldKey == null))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ?? () => Future.value(true),
      child: SafeArea(
        top: safeAreaTop ?? false,
        bottom: safeAreaBottom ?? false,
        minimum: EdgeInsets.only(
          bottom: ScreenUtil().bottomBarHeight,
        ),
        child: Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: appBarSkippable
              ? CustomAppBar.skippable(
                  context,
                  backButtonColor: backButtonColor,
                  height: appbarHeight,
                  skipBehaviour: skipBehaviour!,
                  children: appbarItems,
                )
              : appBarWithMenu
                  ? CustomAppBar.withMenu(
                      context,
                      scaffoldKey: scaffoldKey!,
                      menuButtonColor: AppColors.primaryColor,
                      children: appbarItems,
                    )
                  : appBarWithBack
                      ? CustomAppBar(
                          context,
                          canPop: true,
                          height: appbarHeight,
                          backButtonColor: backButtonColor,
                          result: result,
                          color: appBarColor,
                          backButtonWidget: backButtonWidget,
                          children: appbarItems,
                        )
                      : null,
          drawer: drawer,
          floatingActionButton: floatingActionButton,
          body: Stack(alignment: Alignment.center, children: [
            child,
            if (showUpperShadow)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: Sizes.screenTopShadowHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xde000000), Color(0x00000000)],
                      stops: [0, 0.4],
                      begin: Alignment.topCenter,
                      end: Alignment(0, .1),
                    ),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}

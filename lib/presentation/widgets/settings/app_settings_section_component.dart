import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/config/router/routes.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/domain/models/language_model.dart';
import 'package:notes_mvvm/presentation/viewmodels/settings/settings_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/settings/settings_section_component.dart';
import 'package:notes_mvvm/presentation/widgets/settings/settings_tile_component.dart';

class AppSettingsSectionComponent extends ConsumerWidget {
  const AppSettingsSectionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingsVM = ref.watch(settingsViewModel);
    return SettingsSectionComponent(
      headerIcon: Icons.settings,
      headerTitle: tr('appSettings'),
      titleList: [
        SettingsTileComponent(
          customTitle: Row(
            children: [
              Icon(
                settingsVM.isLightThemeMode
                    ? Icons.wb_sunny
                    : Icons.nights_stay,
                color: context.textTheme.headline4!.color,
              ),
              SizedBox(
                width: Sizes.hMarginSmallest,
              ),
              CustomText.h5(
                context,
                tr('theme'),
                color: context.textTheme.headline4!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          customTrailing: SizedBox(
            width: Sizes.switchThemeButtonWidth,
            child: Switch.adaptive(
              value: settingsVM.isLightThemeMode,
              onChanged: (value) {
                settingsVM.changeTheme(isLight: value);
              },
              activeColor: AppColors.white,
              activeTrackColor: AppColors.lightOrange,
            ),
          ),
        ),
        SettingsTileComponent(
          customTitle: Row(
            children: <Widget>[
              Icon(
                Icons.translate,
                size: Sizes.iconsSizes['s6'],
                color: context.textTheme.headline4!.color,
              ),
              SizedBox(
                width: Sizes.hMarginSmallest,
              ),
              CustomText.h5(
                context,
                tr('language'),
                color: context.textTheme.headline4!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: tr(languagesList
              .firstWhere(
                  (element) => element.code == settingsVM.selectedLanguageCode)
              .name),
          onTap: () {
            NavigationService.navigateTo(
              navigationMethod: NavigationMethod.push,
              page: RoutePaths.settingsLanguage,
              isNamed: true,
            );
          },
        )
      ],
    );
  }
}

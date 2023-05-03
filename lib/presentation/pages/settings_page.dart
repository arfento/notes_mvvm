import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_images.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/popup_page.dart';
import 'package:notes_mvvm/presentation/widgets/components/appbar_with_icon_component.dart';
import 'package:notes_mvvm/presentation/widgets/settings/app_settings_section_component.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.settingsScreenIcon,
          title: tr('settings'),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault,
            horizontal: Sizes.screenHPaddingDefault,
          ),
          child: Column(
            children: const <Widget>[
              AppSettingsSectionComponent(),
            ],
          ),
        ),
      ),
    );
  }
}

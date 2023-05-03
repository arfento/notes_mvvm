import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_images.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/domain/models/language_model.dart';
import 'package:notes_mvvm/popup_page.dart';
import 'package:notes_mvvm/presentation/widgets/components/appbar_with_icon_component.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/settings/language_item_component.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.languageScreenIcon,
          title: tr('language'),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault,
            horizontal: Sizes.screenHPaddingDefault,
          ),
          child: Column(
            children: <Widget>[
              CustomText.h3(
                context,
                tr('selectYourPreferredLanguage'),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Sizes.vMarginMedium,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LanguageItemComponent(
                      languageModel: languagesList[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Sizes.vMarginSmall,
                  );
                },
                itemCount: languagesList.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}

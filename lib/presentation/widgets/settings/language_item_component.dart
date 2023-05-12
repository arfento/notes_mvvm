// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';

import 'package:notes_mvvm/domain/models/language_model.dart';
import 'package:notes_mvvm/presentation/viewmodels/settings/settings_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class LanguageItemComponent extends ConsumerWidget {
  final LanguageModel languageModel;

  const LanguageItemComponent({
    Key? key,
    required this.languageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        ref.read(settingsViewModel).changeLocale(
              langCode: languageModel.code,
            );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.vPaddingSmallest,
          horizontal: Sizes.hPaddingMedium,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(languageModel.flag),
                  radius: Sizes.iconsSizes['s6'],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final selectedLanguage = ref.watch(settingsViewModel.select(
                        (settingsVM) => settingsVM.selectedLanguageCode));
                    return selectedLanguage == languageModel.code
                        ? CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.8),
                            radius: Sizes.iconsSizes['s6'],
                            child: Icon(
                              Icons.check,
                              size: Sizes.iconsSizes['s5'],
                              color: context.theme.primaryColor,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
            SizedBox(
              width: Sizes.hMarginSmall,
            ),
            Expanded(
              child: CustomText.h4(
                context,
                tr(languageModel.name),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

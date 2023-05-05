import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/number_parser.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class MultiSelectionHeaderComponent extends StatelessWidget {
  final HomeViewModel homeVm;
  const MultiSelectionHeaderComponent({
    Key? key,
    required this.homeVm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.hPaddingHighest,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              homeVm.clearNoteSelection();
            },
            icon: const Icon(
              Icons.close,
            ),
            iconSize: Sizes.iconsSizes['s4'],
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: Sizes.iconsSizes['s5'],
            key: const Key('clearSelectedItems'),
          ),
          SizedBox(
            width: Sizes.hMarginSmall,
          ),
          CustomText.h2(
            context,
            AppLocalizations.instance.isAr()
                ? NumberParser.instance.convertToArabicNumbers(
                    input: homeVm.selectedNotesIds.length.toString(),
                  )
                : homeVm.selectedNotesIds.length.toString(),
            weight: FontStyles.fontWeightMedium,
            overflow: TextOverflow.ellipsis,
            key: const Key('selectedItems'),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              homeVm.deleteSelectedNotes();
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.secondaryColor,
            ),
            iconSize: Sizes.iconsSizes['s4'],
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: Sizes.iconsSizes['s5'],
            key: const Key('deleteItemsButton'),
          ),
        ],
      ),
    );
  }
}

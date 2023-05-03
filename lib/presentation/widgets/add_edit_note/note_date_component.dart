// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/date_parser.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';

import 'package:notes_mvvm/presentation/viewmodels/add_edit/add_note_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class NoteDateComponent extends StatelessWidget {
  final AddNoteViewModel addNoteVM;

  const NoteDateComponent({
    Key? key,
    required this.addNoteVM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: Sizes.roundedButtonMediumWidth,
      buttonColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Sizes.roundedButtonSmallRadius,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.hPaddingSmall),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        addNoteVM.pickNoteDate(context: context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CustomText.h5(
              context,
              addNoteVM.noteDate == null
                  ? tr('tapToSelectDate')
                  : DateParser.instance.convertUTCToLocal(addNoteVM.noteDate!),
              color: AppColors.white,
              weight: FontStyles.fontWeightMedium,
              alignment: Alignment.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: Sizes.hMarginSmallest,
          ),
          Icon(
            Icons.date_range,
            size: Sizes.iconsSizes['s5'],
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}

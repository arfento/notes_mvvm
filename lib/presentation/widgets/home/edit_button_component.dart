import 'package:flutter/material.dart';
import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/config/router/routes.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text_button.dart';

class EditButtonComponent extends StatelessWidget {
  final VisualNoteModel visualNoteModel;

  const EditButtonComponent({
    required this.visualNoteModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      elevation: 1,
      minWidth: Sizes.textButtonMinWidth,
      minHeight: Sizes.textButtonMinHeight,
      buttonColor: AppColors.secondaryColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          isNamed: true,
          page: RoutePaths.addEditNote,
          arguments: {'visualNoteModel': visualNoteModel},
        );
      },
      child: CustomText.h5(
        context,
        tr('edit'),
        color: AppColors.white,
        alignment: Alignment.center,
      ),
    );
  }
}

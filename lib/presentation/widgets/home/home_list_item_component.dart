import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:notes_mvvm/presentation/widgets/home/edit_button_component.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_detail_component.dart';

class HomeListItemComponent extends StatelessWidget {
  final VisualNoteModel visualNoteModel;
  final bool isSelectedNote;

  const HomeListItemComponent({
    required this.visualNoteModel,
    required this.isSelectedNote,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: isSelectedNote
          ? context.isDarkMode
              ? AppColors.highlightWhite.withOpacity(0.5)
              : Colors.grey[300]
          : null,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.cardVPadding,
          horizontal: Sizes.cardHRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: HomeDetailComponent(
                visualNoteModel: visualNoteModel,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                EditButtonComponent(
                  visualNoteModel: visualNoteModel,
                ),
                SizedBox(
                  height: Sizes.vMarginSmallest,
                ),
                Container(
                  height: Sizes.noteImageHeight,
                  width: Sizes.noteImageWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.noteImageRadius,
                    ),
                    image: DecorationImage(
                      image: FileImage(
                        File(visualNoteModel.image),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

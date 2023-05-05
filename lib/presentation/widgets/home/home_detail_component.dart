import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/date_parser.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/core/utils/enums.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class HomeDetailComponent extends StatelessWidget {
  final VisualNoteModel visualNoteModel;
  const HomeDetailComponent({
    Key? key,
    required this.visualNoteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: Sizes.noteItemMinHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText.h4(
                context,
                '#' + visualNoteModel.noteId,
                color: AppColors.secondaryColor,
                weight: FontStyles.fontWeightBold,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h5(
                context,
                DateParser.instance.convertEpochToLocal(
                  visualNoteModel.date,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: Sizes.vMarginSmallest,
              ),
              CustomText.h4(
                context,
                visualNoteModel.title,
                weight: FontStyles.fontWeightBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h6(
                context,
                visualNoteModel.description + '.',
                weight: FontStyles.fontWeightBold,
              ),
              SizedBox(
                height: Sizes.vMarginSmallest,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                height: Sizes.statusCircleRadius,
                width: Sizes.statusCircleRadius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: visualNoteModel.status == NoteStatus.open.name
                      ? Colors.green
                      : Colors.blue,
                ),
              ),
              SizedBox(
                width: Sizes.hMarginTiny,
              ),
              CustomText.h5(
                context,
                visualNoteModel.status == NoteStatus.open.name
                    ? tr('open')
                    : tr('closed'),
                weight: FontStyles.fontWeightBold,
                color: visualNoteModel.status == NoteStatus.open.name
                    ? Colors.green
                    : Colors.blue,
              ),
            ],
          )
        ],
      ),
    );
  }
}

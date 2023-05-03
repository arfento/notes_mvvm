// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/core/utils/enums.dart';

import 'package:notes_mvvm/presentation/viewmodels/add_edit/add_note_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/components/check_box_component.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class NoteStatusComponent extends StatelessWidget {
  final AddNoteViewModel addNoteVM;
  const NoteStatusComponent({
    Key? key,
    required this.addNoteVM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomText.h4(
          context,
          tr('noteStatus'),
          color: context.textTheme.headline5!.color,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: Sizes.hPaddingTiny),
        ),
        SizedBox(
          width: Sizes.hMarginSmall,
        ),
        Expanded(
          child: CheckBoxComponent(
            values: NoteStatus.values.map((e) => e.name).toList(),
            selectedValue: addNoteVM.noteStatus,
            onSelected: addNoteVM.pickNoteStatus,
          ),
        ),
      ],
    );
  }
}

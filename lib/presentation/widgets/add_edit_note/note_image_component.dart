import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/app_images.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/viewmodels/add_edit/add_note_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/components/image_pick_component.dart';

class NoteImageComponent extends StatelessWidget {
  final AddNoteViewModel addNoteVM;

  const NoteImageComponent({
    Key? key,
    required this.addNoteVM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: Sizes.noteImageHighRadius,
          backgroundColor: AppColors.primaryColor,
          foregroundImage: addNoteVM.noteImage != null
              ? FileImage(addNoteVM.noteImage!)
              : addNoteVM.visualNoteModel != null
                  ? FileImage(File(addNoteVM.visualNoteModel!.image))
                  : null,
          backgroundImage: addNoteVM.noteImage == null &&
                  addNoteVM.visualNoteModel?.image == null
              ? const AssetImage(AppImages.placeHolderImage)
              : null,
        ),
        Padding(
          padding: EdgeInsets.only(right: Sizes.hPaddingTiny),
          child: ImagePickComponent(
            pickFromCameraFunction: () {
              addNoteVM.pickNoteImage(fromCamera: true);
            },
            pickFromGalleryFunction: () {
              addNoteVM.pickNoteImage(fromCamera: false);
            },
          ),
        ),
      ],
    );
  }
}

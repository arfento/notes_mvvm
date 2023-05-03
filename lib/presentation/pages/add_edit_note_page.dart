import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_images.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:notes_mvvm/popup_page.dart';
import 'package:notes_mvvm/presentation/viewmodels/add_edit/add_note_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/add_edit_note/add_note_textfiled_component.dart';
import 'package:notes_mvvm/presentation/widgets/add_edit_note/note_date_component.dart';
import 'package:notes_mvvm/presentation/widgets/add_edit_note/note_image_component.dart';
import 'package:notes_mvvm/presentation/widgets/add_edit_note/note_status_component.dart';
import 'package:notes_mvvm/presentation/widgets/components/appbar_with_icon_component.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/loading_indicators.dart';

class AddEditNote extends StatefulWidget {
  final VisualNoteModel? visualNoteModel;

  const AddEditNote({
    Key? key,
    required this.visualNoteModel,
  }) : super(key: key);

  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  bool? isNewNote;

  @override
  void initState() {
    super.initState();
    isNewNote = widget.visualNoteModel == null;
  }

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.addNoteScreenIcon,
          title: isNewNote! ? tr("addNewNote") : tr("editNote"),
        ),
      ],
      resizeToAvoidBottomInset: true,
      child: Consumer(
        builder: (context, ref, child) {
          final addNoteVM = ref.watch(addNoteViewModel(widget.visualNoteModel));
          return addNoteVM.isLoading
              ? LoadingIndicators.instance.smallLoadingAnimation(context)
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes.screenVPaddingDefault,
                      horizontal: Sizes.screenHPaddingDefault,
                    ),
                    child: Form(
                        key: addNoteVM.formKey,
                        child: Column(
                          children: <Widget>[
                            NoteImageComponent(addNoteVM: addNoteVM),
                            SizedBox(
                              height: Sizes.vMarginMedium,
                            ),
                            NoteDateComponent(
                              addNoteVM: addNoteVM,
                            ),
                            SizedBox(
                              height: Sizes.vMarginMedium,
                            ),
                            AddNoteTextfiledComponent(
                              title: tr('noteId'),
                              hint: tr('enterNoteId'),
                              validator: addNoteVM.validateID,
                              controller: addNoteVM.noteIdController,
                              keyboardType: TextInputType.number,
                            ),
                            AddNoteTextfiledComponent(
                              title: tr('noteTitle'),
                              hint: tr('enterNoteTitle'),
                              validator: addNoteVM.validateTitle,
                              controller: addNoteVM.noteTitleController,
                              keyboardType: TextInputType.text,
                            ),
                            AddNoteTextfiledComponent(
                              title: tr('noteDescription'),
                              hint: tr('enterNoteDescription'),
                              validator: addNoteVM.validateDescription,
                              controller: addNoteVM.noteDescriptionController,
                              keyboardType: TextInputType.multiline,
                              isMultiline: true,
                              maxLines: 4,
                            ),
                            NoteStatusComponent(
                              addNoteVM: addNoteVM,
                            ),
                            SizedBox(
                              height: Sizes.vMarginHighest,
                            ),
                            CustomButton(
                              text: isNewNote! ? tr('add') : tr('done'),
                              onPressed: () {
                                if (addNoteVM.validateNote()) {
                                  if (isNewNote!) {
                                    addNoteVM.saveNote();
                                  } else {
                                    addNoteVM.updateNote();
                                  }
                                }
                              },
                            )
                          ],
                        )),
                  ),
                );
        },
      ),
    );
  }
}

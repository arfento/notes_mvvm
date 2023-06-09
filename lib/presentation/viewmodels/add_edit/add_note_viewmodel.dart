import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/services/date_parser.dart';
import 'package:notes_mvvm/core/services/date_picker.dart';
import 'package:notes_mvvm/core/services/image_selector.dart';
import 'package:notes_mvvm/core/utils/dialogs.dart';
import 'package:notes_mvvm/core/utils/validators.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:notes_mvvm/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/snack_bar.dart';

final addNoteViewModel = ChangeNotifierProvider.family
    .autoDispose<AddNoteViewModel, VisualNoteModel?>(
        (ref, visualNote) => AddNoteViewModel(ref, visualNote));

class AddNoteViewModel extends ChangeNotifier {
  AddNoteViewModel(this.ref, this.visualNoteModel) {
    database = ref.read(databaseProvider);
    if (visualNoteModel != null) {
      noteIdController.text = visualNoteModel!.noteId;
      noteTitleController.text = visualNoteModel!.title;
      noteDescriptionController.text = visualNoteModel!.description;
      noteDate =
          DateParser.instance.convertEpochToLocalDate(visualNoteModel!.date);
      noteStatus = visualNoteModel!.status;
    }
  }

  Ref ref;
  bool isLoading = false;
  late DatabaseHelpers database;
  final VisualNoteModel? visualNoteModel;

  final formKey = GlobalKey<FormState>();
  TextEditingController noteIdController = TextEditingController();
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();
  File? noteImage;
  DateTime? noteDate;
  String? noteStatus;

  String? validateID(String? value) {
    return Validators.instance.validateInteger(value);
  }

  String? validateTitle(String? value) {
    return Validators.instance.validateTitle(value);
  }

  String? validateDescription(String? value) {
    return Validators.instance.validateDescription(value);
  }

  Future pickNoteImage({required bool fromCamera}) async {
    noteImage = await ImageSelector.instance.pickImage(
      fromCamera: fromCamera,
    );
    notifyListeners();
  }

  pickNoteDate({
    required BuildContext context,
  }) async {
    final selectedDate =
        await DatePicker.instance.selectDate(context, initialDate: noteDate);
    if (selectedDate != null) {
      final selectedTime =
          await DatePicker.instance.selectTime(context, initialDate: noteDate);
      if (selectedTime != null) {
        noteDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  pickNoteStatus(String? value) {
    noteStatus = value!;
    notifyListeners();
  }

  bool validateNote() {
    if (formKey.currentState!.validate()) {
      if (validateUniqueID()) {
        return validateNoteInputs();
      }
    }
    return false;
  }

  bool validateUniqueID() {
    bool isUniqueID = true;
    ref.read(homeViewModel).notesList.forEach((note) {
      if (note.noteId == noteIdController.text &&
          note.noteId != visualNoteModel?.noteId) {
        CustomSnackBar.showCommonRawSnackBar(
          NavigationService.context,
          title: tr('idAlreadyExist'),
          description: tr('pleaseAddDifferentNoteID'),
        );
        isUniqueID = false;
      }
    });
    return isUniqueID;
  }

  bool validateNoteInputs() {
    bool validate = false;
    if (noteImage == null && visualNoteModel == null) {
      CustomSnackBar.showCommonRawSnackBar(
        NavigationService.context,
        title: tr('noImageSelected'),
        description: tr('pleaseSelectNoteImage'),
      );
    } else if (noteDate == null) {
      CustomSnackBar.showCommonRawSnackBar(
        NavigationService.context,
        title: tr('noDateSelected'),
        description: tr('pleaseSelectNoteDate'),
      );
    } else if (noteStatus == null) {
      CustomSnackBar.showCommonRawSnackBar(
        NavigationService.context,
        title: tr('noStatusSelected'),
        description: tr('pleaseSelectNoteStatus'),
      );
    } else {
      validate = true;
    }
    return validate;
  }

  Future saveNote() async {
    isLoading = true;
    notifyListeners();
    try {
      final imagePath = await saveImageToLocalStorage();
      await database.addNotes(
        visualNoteModel: VisualNoteModel(
          noteId: noteIdController.text,
          date: DateParser.instance.convertDateToUTCEpoch(noteDate!),
          title: noteTitleController.text,
          description: noteDescriptionController.text,
          image: imagePath!,
          status: noteStatus!,
        ),
      );
    } catch (e) {
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
    ref.read(homeViewModel).getNotes();
    NavigationService.goBack();
  }

  Future<String?> saveImageToLocalStorage() async {
    final storedImage = await ImageSelector.instance.saveImageLocally(
        imageFile: noteImage ?? File(visualNoteModel!.image),
        fileName: noteIdController.text);
    return storedImage;
  }

  Future updateNote() async {
    isLoading = true;
    notifyListeners();
    try {
      final imagePath = noteImage != null || isIdUpdated()
          ? await saveImageToLocalStorage()
          : visualNoteModel!.image;
      await database.updateNotes(
          noteId: visualNoteModel!.noteId,
          visualNoteModel: VisualNoteModel(
            noteId: noteIdController.text,
            date: DateParser.instance.convertDateToUTCEpoch(noteDate!),
            title: noteTitleController.text,
            description: noteDescriptionController.text,
            image: imagePath!,
            status: noteStatus!,
          ));
      if (isIdUpdated()) {
        await deleteOldImageFromLocalStorage();
      } else {
        ImageSelector.instance.clearImageCache();
      }
    } catch (e) {
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
    ref.read(homeViewModel).getNotes();
    NavigationService.goBack();
  }

  bool isIdUpdated() {
    return visualNoteModel!.noteId != noteIdController.text;
  }

  Future deleteOldImageFromLocalStorage() async {
    await ImageSelector.instance
        .deleteImageLocally(imageFile: File(visualNoteModel!.image));
  }
}

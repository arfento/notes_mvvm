import 'package:get/get.dart';
import 'package:notes_mvvm/core/localization/ar.dart';
import 'package:notes_mvvm/core/localization/en.dart';
import 'package:notes_mvvm/localization/add_edit_note/ar.dart';
import 'package:notes_mvvm/localization/add_edit_note/en.dart';
import 'package:notes_mvvm/localization/general/ar.dart';
import 'package:notes_mvvm/localization/general/en.dart';
import 'package:notes_mvvm/localization/home/ar.dart';
import 'package:notes_mvvm/localization/home/en.dart';

class LanguageTranslation extends Translations {
  Map<String, String> en = coreEn;
  Map<String, String> ar = coreAr;

  LanguageTranslation() {
    en
      ..addAll(generalEn)
      ..addAll(notesEn)
      ..addAll(addEditNoteEn);
    ar
      ..addAll(generalAr)
      ..addAll(notesAr)
      ..addAll(addEditNoteAr);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text_field.dart';

class AddNoteTextfiledComponent extends StatelessWidget {
  final String title;
  final String hint;
  final String? initialValue;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final bool isMultiline;
  final int maxLines;

  const AddNoteTextfiledComponent({
    Key? key,
    required this.title,
    required this.hint,
    this.initialValue,
    this.controller,
    required this.validator,
    this.onSaved,
    this.keyboardType,
    this.isMultiline = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomText.h4(
          context,
          title,
          color: context.textTheme.headline5!.color,
          padding: AppLocalizations.instance.isAr()
              ? EdgeInsets.only(right: Sizes.hPaddingTiny)
              : EdgeInsets.only(left: Sizes.hPaddingTiny),
        ),
        SizedBox(
          height: Sizes.vPaddingSmallest,
        ),
        CustomTextField(
          controller: controller,
          validationColor: AppColors.primaryColor,
          textInputAction:
              isMultiline ? TextInputAction.newline : TextInputAction.next,
          keyboardType: keyboardType,
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          margin: EdgeInsets.only(
            bottom: Sizes.textFieldVMarginMedium,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: Sizes.textFieldVPaddingMedium,
            horizontal: Sizes.textFieldHPaddingMedium,
          ),
          fillColor: Colors.transparent,
          hintText: hint,
          key: ValueKey(title),
        ),
      ],
    );
  }
}

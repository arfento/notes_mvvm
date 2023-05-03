import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class CustomSnackBar {
  static showCommonRawSnackBar(
    BuildContext context, {
    String title = '',
    String description = '',
    Gradient? backgroundGradient,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Duration duration = const Duration(seconds: 4),
    SnackPosition snackPosition = SnackPosition.TOP,
    bool isDismissible = true,
    DismissDirection dismissDirection = DismissDirection.up,
    Function? onTap,
  }) {
    Get.rawSnackbar(
      titleText: CustomText.h4(
        context,
        title,
        weight: FontStyles.fontWeightMedium,
        color: AppColors.lightBlack,
      ),
      messageText: CustomText.h5(
        context,
        description,
        color: AppColors.lightBlack,
      ),
      backgroundGradient:
          backgroundGradient ?? AppColors.primaryIngredientColor,
      borderRadius: borderRadius ?? Sizes.snackBarRadius,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Sizes.vPaddingSmall,
            horizontal: Sizes.hPaddingMedium,
          ),
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: Sizes.hMarginComment,
          ),
      duration: duration,
      snackPosition: snackPosition,
      dismissDirection: dismissDirection,
      isDismissible: isDismissible,
      onTap: (data) {},
    );
  }
}

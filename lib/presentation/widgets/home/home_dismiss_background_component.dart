import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';

class HomeDismissBackgroundComponent extends StatelessWidget {
  const HomeDismissBackgroundComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.hPaddingMedium,
      ),
      child: Icon(
        Icons.delete,
        size: Sizes.iconsSizes['s2'],
        color: AppColors.white,
      ),
    );
  }
}

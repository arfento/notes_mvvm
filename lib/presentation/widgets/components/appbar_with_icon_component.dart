import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class AppBarWithIconComponent extends StatelessWidget {
  final String icon;
  final String title;

  const AppBarWithIconComponent({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(
            icon,
          ),
          size: Sizes.appBarIconSize,
        ),
        SizedBox(
          width: Sizes.hMarginComment,
        ),
        CustomText.h6(
          context,
          title,
          weight: FontStyles.fontWeightSemiBold,
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

import 'package:notes_mvvm/presentation/widgets/settings/settings_tile_component.dart';

class SettingsSectionComponent extends StatelessWidget {
  final IconData headerIcon;
  final String headerTitle;
  final Widget? headerTrailing;
  final List<SettingsTileComponent> titleList;

  const SettingsSectionComponent({
    Key? key,
    required this.headerIcon,
    required this.headerTitle,
    this.headerTrailing,
    required this.titleList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Sizes.vMarginMedium,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(
          Sizes.dialogSmallRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.vPaddingTiny,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(
              headerIcon,
            ),
            title: CustomText.h4(
              context,
              headerTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: headerTrailing,
          ),
          ...titleList,
        ],
      ),
    );
  }
}

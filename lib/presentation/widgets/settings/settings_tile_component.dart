// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class SettingsTileComponent extends StatelessWidget {
  final String? title;
  final Widget? customTitle;
  final String? trailing;
  final Widget? customTrailing;
  final VoidCallback? onTap;

  const SettingsTileComponent({
    Key? key,
    this.title,
    this.customTitle,
    this.trailing,
    this.customTrailing,
    this.onTap,
  })  : assert((title != null ||
            customTitle != null && trailing != null ||
            customTrailing != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: customTitle ??
          CustomText.h5(
            context,
            title!,
            color: context.textTheme.headline4!.color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      trailing: customTrailing ??
          FittedBox(
            child: CustomText.h5(
              context,
              trailing!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      onTap: onTap,
    );
  }
}

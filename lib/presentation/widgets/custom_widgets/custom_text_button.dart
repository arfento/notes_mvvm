import 'package:flutter/material.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final double minHeight;
  final double minWidth;
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final MaterialTapTargetSize? tapTargetSize;

  const CustomTextButton({
    this.minHeight = 0,
    this.minWidth = 0,
    this.child,
    this.text,
    required this.onPressed,
    this.shape,
    this.elevation,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.padding,
    this.onLongPress,
    this.tapTargetSize,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: splashColor ?? AppColors.primaryColor,
          shape: shape,
          elevation: elevation ?? 0,
          backgroundColor: buttonColor,
          shadowColor: shadowColor,
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: Sizes.vPaddingTiny,
                horizontal: Sizes.hPaddingSmallest,
              ),
          minimumSize: Size(minWidth, minHeight),
          tapTargetSize: tapTargetSize,
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: child ??
            CustomText.h5(
              context,
              text!,
              color: AppColors.primaryColor,
              alignment: Alignment.center,
            ),
      ),
    );
  }
}

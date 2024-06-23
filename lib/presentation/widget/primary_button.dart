import 'package:flutter/material.dart';

import '../../../common/common.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? radius;
  final Color? textColor;
  final double? height;
  final TextStyle? textStyle;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onTap,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
    this.radius,
    this.textColor,
    this.height,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.safeBlockVertical * 5.5,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorConstant.primaryColor,
        borderRadius: BorderRadius.circular(radius ?? 6),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: padding ?? EdgeInsets.zero,
        ),
        child: Center(
          child: Text(text, style: textStyle ?? TextStyle(color: textColor ?? Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 4, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

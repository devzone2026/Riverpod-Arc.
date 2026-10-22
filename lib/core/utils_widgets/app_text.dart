import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

enum AppTextVariant { heading, title, body, bodyMuted, label, caption, button, link, headingBold }

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
  });

  const AppText.heading(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.heading;


  const AppText.headingBold(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.headingBold;

  const AppText.title(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.title;

  const AppText.body(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.body;

  const AppText.muted(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.bodyMuted;

  const AppText.label(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.label;

  const AppText.caption(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.caption;

  const AppText.link(this.text, {super.key, this.textAlign, this.color, this.maxLines, this.overflow, this.fontWeight, this.fontSize})
    : variant = AppTextVariant.link;

  TextStyle _styleFor(AppTextVariant v) {
    switch (v) {
      case AppTextVariant.heading:
        return AppTextStyles.heading;
      case AppTextVariant.headingBold:
        return AppTextStyles.headingBold;
      case AppTextVariant.title:
        return AppTextStyles.title;
      case AppTextVariant.body:
        return AppTextStyles.body;
      case AppTextVariant.bodyMuted:
        return AppTextStyles.bodyMuted;
      case AppTextVariant.label:
        return AppTextStyles.label;
      case AppTextVariant.caption:
        return AppTextStyles.caption;
      case AppTextVariant.button:
        return AppTextStyles.button;
      case AppTextVariant.link:
        return AppTextStyles.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = _styleFor(variant);
    style = style.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize, // now actually applied
    );
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );
  }
}

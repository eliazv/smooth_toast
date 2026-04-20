import 'package:flutter/material.dart';

/// Visual customization for [SmoothToast].
class SmoothToastStyle {
  const SmoothToastStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    this.shadowColor,
    this.textStyle,
    this.actionTextStyle,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.elevation = 12,
    this.iconSize = 22,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    this.showCloseIcon = false,
    this.closeIcon = Icons.close,
    this.closeIconColor,
    this.closeIconSize = 20,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color? shadowColor;
  final TextStyle? textStyle;
  final TextStyle? actionTextStyle;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  final double iconSize;
  final int maxLines;
  final TextOverflow overflow;
  final bool showCloseIcon;
  final IconData closeIcon;
  final Color? closeIconColor;
  final double closeIconSize;

  SmoothToastStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    Color? shadowColor,
    TextStyle? textStyle,
    TextStyle? actionTextStyle,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? elevation,
    double? iconSize,
    int? maxLines,
    TextOverflow? overflow,
    bool? showCloseIcon,
    IconData? closeIcon,
    Color? closeIconColor,
    double? closeIconSize,
  }) {
    return SmoothToastStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textStyle: textStyle ?? this.textStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
      iconSize: iconSize ?? this.iconSize,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      showCloseIcon: showCloseIcon ?? this.showCloseIcon,
      closeIcon: closeIcon ?? this.closeIcon,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      closeIconSize: closeIconSize ?? this.closeIconSize,
    );
  }
}

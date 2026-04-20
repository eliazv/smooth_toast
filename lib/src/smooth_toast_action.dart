import 'dart:async';

import 'package:flutter/material.dart';

/// Right-side action displayed inside a toast.
class SmoothToastAction {
  const SmoothToastAction({
    required this.label,
    required this.onPressed,
    this.icon,
    this.closeOnTap = true,
    this.textStyle,
    this.foregroundColor,
    this.backgroundColor,
    this.tooltip,
  });

  final String label;
  final FutureOr<void> Function() onPressed;
  final IconData? icon;
  final bool closeOnTap;
  final TextStyle? textStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String? tooltip;
}

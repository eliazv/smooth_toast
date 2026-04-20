import 'dart:async';

import 'package:flutter/material.dart';

import 'smooth_toast_action.dart';
import 'smooth_toast_style.dart';

enum SmoothToastType { neutral, success, error, info, warning }

enum SmoothToastAlignment { top, bottom }

/// Overlay toast helper with a compact static API.
class SmoothToast {
  static OverlayEntry? _activeEntry;

  static void show(
    BuildContext context, {
    required String message,
    SmoothToastType type = SmoothToastType.neutral,
    IconData? icon,
    SmoothToastStyle? style,
    SmoothToastAction? action,
    SmoothToastAlignment alignment = SmoothToastAlignment.top,
    Duration duration = const Duration(seconds: 3),
    Duration animationDuration = const Duration(milliseconds: 280),
    Curve animationCurve = Curves.easeOutCubic,
    Curve reverseAnimationCurve = Curves.easeInCubic,
    bool dismissOnTap = true,
    bool dismissOnSwipe = true,
    bool replaceCurrent = true,
    double topOffset = 8,
    double bottomOffset = 20,
    bool rootOverlay = true,
  }) {
    final OverlayState? overlay =
        Navigator.maybeOf(context, rootNavigator: rootOverlay)?.overlay ??
        Overlay.maybeOf(context, rootOverlay: rootOverlay);
    if (overlay == null) {
      return;
    }

    if (replaceCurrent) {
      dismiss(immediately: true);
    }

    final SmoothToastStyle resolvedStyle =
        style ?? _defaultStyleFor(context, type: type);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext entryContext) {
        return _SmoothToastWidget(
          message: message,
          icon: icon ?? _defaultIconFor(type),
          style: resolvedStyle,
          action: action,
          alignment: alignment,
          duration: duration,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          reverseAnimationCurve: reverseAnimationCurve,
          dismissOnTap: dismissOnTap,
          dismissOnSwipe: dismissOnSwipe,
          topOffset: topOffset,
          bottomOffset: bottomOffset,
          onDismissed: () {
            if (identical(_activeEntry, entry)) {
              _activeEntry = null;
            }
            entry.remove();
          },
        );
      },
    );

    _activeEntry = entry;
    overlay.insert(entry);
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    IconData icon = Icons.check_circle,
    SmoothToastStyle? style,
    SmoothToastAction? action,
    SmoothToastAlignment alignment = SmoothToastAlignment.top,
    Duration duration = const Duration(seconds: 3),
    Duration animationDuration = const Duration(milliseconds: 280),
    bool dismissOnTap = true,
    bool dismissOnSwipe = true,
    bool replaceCurrent = true,
  }) {
    show(
      context,
      message: message,
      type: SmoothToastType.success,
      icon: icon,
      style: style,
      action: action,
      alignment: alignment,
      duration: duration,
      animationDuration: animationDuration,
      dismissOnTap: dismissOnTap,
      dismissOnSwipe: dismissOnSwipe,
      replaceCurrent: replaceCurrent,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    IconData icon = Icons.error_outline,
    SmoothToastStyle? style,
    SmoothToastAction? action,
    SmoothToastAlignment alignment = SmoothToastAlignment.top,
    Duration duration = const Duration(seconds: 4),
    Duration animationDuration = const Duration(milliseconds: 280),
    bool dismissOnTap = true,
    bool dismissOnSwipe = true,
    bool replaceCurrent = true,
  }) {
    show(
      context,
      message: message,
      type: SmoothToastType.error,
      icon: icon,
      style: style,
      action: action,
      alignment: alignment,
      duration: duration,
      animationDuration: animationDuration,
      dismissOnTap: dismissOnTap,
      dismissOnSwipe: dismissOnSwipe,
      replaceCurrent: replaceCurrent,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    IconData icon = Icons.info_outline,
    SmoothToastStyle? style,
    SmoothToastAction? action,
    SmoothToastAlignment alignment = SmoothToastAlignment.top,
    Duration duration = const Duration(seconds: 3),
    Duration animationDuration = const Duration(milliseconds: 280),
    bool dismissOnTap = true,
    bool dismissOnSwipe = true,
    bool replaceCurrent = true,
  }) {
    show(
      context,
      message: message,
      type: SmoothToastType.info,
      icon: icon,
      style: style,
      action: action,
      alignment: alignment,
      duration: duration,
      animationDuration: animationDuration,
      dismissOnTap: dismissOnTap,
      dismissOnSwipe: dismissOnSwipe,
      replaceCurrent: replaceCurrent,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    IconData icon = Icons.warning_amber_rounded,
    SmoothToastStyle? style,
    SmoothToastAction? action,
    SmoothToastAlignment alignment = SmoothToastAlignment.top,
    Duration duration = const Duration(seconds: 3),
    Duration animationDuration = const Duration(milliseconds: 280),
    bool dismissOnTap = true,
    bool dismissOnSwipe = true,
    bool replaceCurrent = true,
  }) {
    show(
      context,
      message: message,
      type: SmoothToastType.warning,
      icon: icon,
      style: style,
      action: action,
      alignment: alignment,
      duration: duration,
      animationDuration: animationDuration,
      dismissOnTap: dismissOnTap,
      dismissOnSwipe: dismissOnSwipe,
      replaceCurrent: replaceCurrent,
    );
  }

  static void dismiss({bool immediately = true}) {
    final OverlayEntry? current = _activeEntry;
    if (current == null) {
      return;
    }

    if (immediately) {
      current.remove();
      _activeEntry = null;
      return;
    }

    current.markNeedsBuild();
  }

  static IconData _defaultIconFor(SmoothToastType type) {
    switch (type) {
      case SmoothToastType.success:
        return Icons.check_circle;
      case SmoothToastType.error:
        return Icons.error_outline;
      case SmoothToastType.info:
        return Icons.info_outline;
      case SmoothToastType.warning:
        return Icons.warning_amber_rounded;
      case SmoothToastType.neutral:
        return Icons.notifications_none;
    }
  }

  static SmoothToastStyle _defaultStyleFor(
    BuildContext context, {
    required SmoothToastType type,
  }) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    switch (type) {
      case SmoothToastType.success:
        return SmoothToastStyle(
          backgroundColor: isDark
              ? const Color(0xFF14532D)
              : const Color(0xFF16A34A),
          textColor: Colors.white,
          iconColor: Colors.white,
          shadowColor: Colors.black.withValues(alpha: 0.26),
        );
      case SmoothToastType.error:
        return SmoothToastStyle(
          backgroundColor: isDark
              ? const Color(0xFF7F1D1D)
              : const Color(0xFFDC2626),
          textColor: Colors.white,
          iconColor: Colors.white,
          shadowColor: Colors.black.withValues(alpha: 0.28),
        );
      case SmoothToastType.info:
        return SmoothToastStyle(
          backgroundColor: isDark
              ? const Color(0xFF1E3A8A)
              : const Color(0xFF2563EB),
          textColor: Colors.white,
          iconColor: Colors.white,
          shadowColor: Colors.black.withValues(alpha: 0.24),
        );
      case SmoothToastType.warning:
        return SmoothToastStyle(
          backgroundColor: isDark
              ? const Color(0xFF854D0E)
              : const Color(0xFFF59E0B),
          textColor: isDark ? Colors.white : Colors.black87,
          iconColor: isDark ? Colors.white : Colors.black87,
          shadowColor: Colors.black.withValues(alpha: 0.24),
        );
      case SmoothToastType.neutral:
        return SmoothToastStyle(
          backgroundColor: isDark
              ? colorScheme.surfaceContainerHigh
              : colorScheme.inverseSurface,
          textColor: isDark
              ? colorScheme.onSurface
              : colorScheme.onInverseSurface,
          iconColor: isDark
              ? colorScheme.onSurface
              : colorScheme.onInverseSurface,
          shadowColor: Colors.black.withValues(alpha: 0.2),
        );
    }
  }
}

class _SmoothToastWidget extends StatefulWidget {
  const _SmoothToastWidget({
    required this.message,
    required this.icon,
    required this.style,
    required this.alignment,
    required this.duration,
    required this.animationDuration,
    required this.animationCurve,
    required this.reverseAnimationCurve,
    required this.dismissOnTap,
    required this.dismissOnSwipe,
    required this.topOffset,
    required this.bottomOffset,
    required this.onDismissed,
    this.action,
  });
  final String message;
  final IconData icon;
  final SmoothToastStyle style;
  final SmoothToastAction? action;
  final SmoothToastAlignment alignment;
  final Duration duration;
  final Duration animationDuration;
  final Curve animationCurve;
  final Curve reverseAnimationCurve;
  final bool dismissOnTap;
  final bool dismissOnSwipe;
  final double topOffset;
  final double bottomOffset;
  final VoidCallback onDismissed;

  @override
  State<_SmoothToastWidget> createState() => _SmoothToastWidgetState();
}

class _SmoothToastWidgetState extends State<_SmoothToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  Timer? _dismissTimer;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      reverseDuration: widget.animationDuration,
      vsync: this,
    );

    final Offset beginOffset = widget.alignment == SmoothToastAlignment.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _offsetAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.animationCurve,
            reverseCurve: widget.reverseAnimationCurve,
          ),
        );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.forward();
    _dismissTimer = Timer(widget.duration, _dismissAnimated);
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismissAnimated() async {
    if (_isClosing) {
      return;
    }
    _isClosing = true;
    await _controller.reverse();
    if (mounted) {
      widget.onDismissed();
    }
  }

  void _handleActionPressed() async {
    await widget.action?.onPressed();
    if (!mounted) {
      return;
    }
    if (widget.action?.closeOnTap ?? false) {
      await _dismissAnimated();
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets margin = widget.style.margin;
    final double verticalAnchor = widget.alignment == SmoothToastAlignment.top
        ? MediaQuery.of(context).padding.top + widget.topOffset
        : MediaQuery.of(context).padding.bottom + widget.bottomOffset;

    return Positioned(
      top: widget.alignment == SmoothToastAlignment.top ? verticalAnchor : null,
      bottom: widget.alignment == SmoothToastAlignment.bottom
          ? verticalAnchor
          : null,
      left: margin.left,
      right: margin.right,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _offsetAnimation,
            child: GestureDetector(
              onTap: widget.dismissOnTap ? _dismissAnimated : null,
              onVerticalDragEnd: !widget.dismissOnSwipe
                  ? null
                  : (DragEndDetails details) {
                      final double velocity = details.primaryVelocity ?? 0;
                      if (velocity.abs() < 220) {
                        return;
                      }
                      final bool validDirection =
                          widget.alignment == SmoothToastAlignment.top
                          ? velocity < 0
                          : velocity > 0;
                      if (validDirection) {
                        _dismissAnimated();
                      }
                    },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.style.backgroundColor,
                  borderRadius: BorderRadius.circular(
                    widget.style.borderRadius,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:
                          widget.style.shadowColor ??
                          Colors.black.withValues(alpha: 0.2),
                      blurRadius: widget.style.elevation,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: widget.style.padding,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        widget.icon,
                        color: widget.style.iconColor,
                        size: widget.style.iconSize,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.message,
                          maxLines: widget.style.maxLines,
                          overflow: widget.style.overflow,
                          style:
                              widget.style.textStyle ??
                              TextStyle(
                                color: widget.style.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      if (widget.action != null) ...<Widget>[
                        const SizedBox(width: 8),
                        _ToastActionButton(
                          action: widget.action!,
                          defaultTextColor: widget.style.textColor,
                          defaultTextStyle: widget.style.actionTextStyle,
                          onPressed: _handleActionPressed,
                        ),
                      ],
                      if (widget.style.showCloseIcon) ...<Widget>[
                        const SizedBox(width: 4),
                        IconButton(
                          tooltip: 'Close notification',
                          constraints: const BoxConstraints(
                            minHeight: 32,
                            minWidth: 32,
                          ),
                          visualDensity: VisualDensity.compact,
                          onPressed: _dismissAnimated,
                          icon: Icon(
                            widget.style.closeIcon,
                            color:
                                widget.style.closeIconColor ??
                                widget.style.textColor,
                            size: widget.style.closeIconSize,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastActionButton extends StatelessWidget {
  const _ToastActionButton({
    required this.action,
    required this.defaultTextColor,
    required this.defaultTextStyle,
    required this.onPressed,
  });

  final SmoothToastAction action;
  final Color defaultTextColor;
  final TextStyle? defaultTextStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Widget label = Text(
      action.label,
      style:
          defaultTextStyle?.copyWith(
            color: action.foregroundColor ?? defaultTextColor,
            fontWeight: FontWeight.w700,
          ) ??
          TextStyle(
            color: action.foregroundColor ?? defaultTextColor,
            fontWeight: FontWeight.w700,
          ),
    );

    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: action.foregroundColor ?? defaultTextColor,
      backgroundColor: action.backgroundColor,
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: const Size(44, 32),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );

    final Widget child = action.icon == null
        ? TextButton(style: style, onPressed: onPressed, child: label)
        : TextButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(action.icon, size: 18),
            label: label,
          );

    if (action.tooltip == null || action.tooltip!.isEmpty) {
      return child;
    }

    return Tooltip(message: action.tooltip!, child: child);
  }
}

extension SmoothToastContextExtension on BuildContext {
  void showSuccessToast(
    String message, {
    SmoothToastAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    SmoothToast.showSuccess(
      this,
      message: message,
      action: action,
      duration: duration,
    );
  }

  void showErrorToast(
    String message, {
    SmoothToastAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    SmoothToast.showError(
      this,
      message: message,
      action: action,
      duration: duration,
    );
  }

  void showInfoToast(
    String message, {
    SmoothToastAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    SmoothToast.showInfo(
      this,
      message: message,
      action: action,
      duration: duration,
    );
  }

  void showWarningToast(
    String message, {
    SmoothToastAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    SmoothToast.showWarning(
      this,
      message: message,
      action: action,
      duration: duration,
    );
  }
}

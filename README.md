# smooth_toast

[![pub package](https://img.shields.io/pub/v/smooth_toast.svg)](https://pub.dev/packages/smooth_toast)
[![likes](https://img.shields.io/pub/likes/smooth_toast)](https://pub.dev/packages/smooth_toast)

A smooth, reusable, highly customizable toast package for Flutter.

Show elegant top or bottom overlay notifications with:

- built-in success/error/info/warning presets
- full color and typography customization
- configurable timings and animations
- optional right-side action button
- tap/swipe/programmatic dismiss

## Installation

```yaml
dependencies:
  smooth_toast: ^0.1.0
```

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:smooth_toast/smooth_toast.dart';

SmoothToast.showSuccess(
  context,
  message: 'Saved successfully',
);
```

## Main API

```dart
SmoothToast.show(
  context,
  message: 'Profile updated',
  type: SmoothToastType.success,
  duration: const Duration(seconds: 3),
  alignment: SmoothToastAlignment.top,
  action: SmoothToastAction(
    label: 'Undo',
    onPressed: () {
      // rollback logic
    },
  ),
);
```

## Custom style

```dart
SmoothToast.show(
  context,
  message: 'Custom themed toast',
  style: SmoothToastStyle(
    backgroundColor: const Color(0xFF111827),
    textColor: Colors.white,
    iconColor: const Color(0xFF22D3EE),
    borderRadius: 18,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: const EdgeInsets.symmetric(horizontal: 12),
    textStyle: const TextStyle(fontWeight: FontWeight.w700),
  ),
);
```

## Extension helpers

```dart
context.showSuccessToast('Done');
context.showErrorToast('Something went wrong');
context.showInfoToast('Sync in progress');
context.showWarningToast('Check your connection');
```

## Behavior notes

- By default, a new toast replaces the current visible one.
- Toasts auto-dismiss after `duration`.
- Set `dismissOnTap` and `dismissOnSwipe` as needed.
- Call `SmoothToast.dismiss()` to close programmatically.

## Example

Run the example app:

```bash
cd example
flutter run
```

## Development

From package root:

```bash
flutter analyze
flutter test
```

## License

MIT

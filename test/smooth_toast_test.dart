import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_toast/smooth_toast.dart';

void main() {
  testWidgets('shows and auto-dismisses toast', (WidgetTester tester) async {
    await tester.pumpWidget(const _TestHost());

    await tester.tap(find.text('show-basic'));
    await tester.pump();

    expect(find.text('Basic toast'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Basic toast'), findsNothing);
  });

  testWidgets('action button invokes callback', (WidgetTester tester) async {
    await tester.pumpWidget(const _TestHost());

    await tester.tap(find.text('show-action'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 320));

    expect(find.text('RETRY'), findsOneWidget);

    await tester.tap(find.text('RETRY'));
    await tester.pump();

    expect(find.text('Action count: 1'), findsOneWidget);
  });

  testWidgets('replaceCurrent hides previous toast', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _TestHost());

    await tester.tap(find.text('show-first'));
    await tester.pump();
    expect(find.text('First toast'), findsOneWidget);

    await tester.tap(find.text('show-second'));
    await tester.pump();

    expect(find.text('Second toast'), findsOneWidget);
    expect(find.text('First toast'), findsNothing);
  });
}

class _TestHost extends StatefulWidget {
  const _TestHost();

  @override
  State<_TestHost> createState() => _TestHostState();
}

class _TestHostState extends State<_TestHost> {
  int _actionCount = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext innerContext) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Text('Action count: $_actionCount'),
                TextButton(
                  onPressed: () {
                    SmoothToast.showInfo(
                      innerContext,
                      message: 'Basic toast',
                      duration: const Duration(seconds: 2),
                    );
                  },
                  child: const Text('show-basic'),
                ),
                TextButton(
                  onPressed: () {
                    SmoothToast.showError(
                      innerContext,
                      message: 'Action toast',
                      action: SmoothToastAction(
                        label: 'RETRY',
                        onPressed: () {
                          setState(() {
                            _actionCount++;
                          });
                        },
                      ),
                    );
                  },
                  child: const Text('show-action'),
                ),
                TextButton(
                  onPressed: () {
                    SmoothToast.show(
                      innerContext,
                      message: 'First toast',
                      duration: const Duration(seconds: 8),
                    );
                  },
                  child: const Text('show-first'),
                ),
                TextButton(
                  onPressed: () {
                    SmoothToast.showSuccess(
                      innerContext,
                      message: 'Second toast',
                    );
                  },
                  child: const Text('show-second'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

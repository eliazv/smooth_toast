import 'package:flutter/material.dart';
import 'package:smooth_toast/smooth_toast.dart';

void main() {
  runApp(const SmoothToastExampleApp());
}

class SmoothToastExampleApp extends StatelessWidget {
  const SmoothToastExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'smooth_toast example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0EA5E9)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0EA5E9),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('smooth_toast example')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              FilledButton.icon(
                onPressed: () {
                  SmoothToast.showSuccess(
                    context,
                    message: 'Profilo salvato correttamente',
                  );
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Success toast'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  SmoothToast.showError(
                    context,
                    message: 'Errore durante il caricamento',
                    action: SmoothToastAction(
                      label: 'Riprova',
                      icon: Icons.refresh_rounded,
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.error_outline),
                label: const Text('Error con azione a destra'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  SmoothToast.show(
                    context,
                    message: 'Toast custom in basso con durata lunga',
                    type: SmoothToastType.neutral,
                    alignment: SmoothToastAlignment.bottom,
                    duration: const Duration(seconds: 5),
                    style: const SmoothToastStyle(
                      backgroundColor: Color(0xFF111827),
                      textColor: Colors.white,
                      iconColor: Color(0xFF22D3EE),
                      showCloseIcon: true,
                    ),
                    action: SmoothToastAction(label: 'UNDO', onPressed: () {}),
                  );
                },
                icon: const Icon(Icons.tune_rounded),
                label: const Text('Custom toast bottom'),
              ),
              const SizedBox(height: 28),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Action counter: $_counter\n'
                    'Ogni tap su "Riprova" incrementa il contatore.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

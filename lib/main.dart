import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _updater = ShorebirdUpdater();
  Patch? _currentPatch;

  @override
  void initState() {
    super.initState();
    _updater.readCurrentPatch().then((patch) {
      setState(() => _currentPatch = patch);
    });
  }

  Future<void> _checkForUpdate() async {
    final status = await _updater.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      await _updater.update();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shorebird Code Push Application ')),
      body: Center(
        child: Text(
          'Patch Value is: ${_currentPatch?.number ?? "None"}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkForUpdate,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

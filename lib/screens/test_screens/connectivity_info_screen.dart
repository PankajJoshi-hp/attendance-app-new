import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityInfoScreen extends StatefulWidget {
  const ConnectivityInfoScreen({super.key});

  @override
  State<ConnectivityInfoScreen> createState() => _ConnectivityInfoScreenState();
}

class _ConnectivityInfoScreenState extends State<ConnectivityInfoScreen> {
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    // Listen to connectivity changes
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        _connectionStatus = result.first.toString().split('.').last;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = connectivityResult.toString().split('.').last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Connection Status:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _connectionStatus,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _connectionStatus == 'none' ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkConnectivity,
              child: const Text('Check Connection'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HashCodesScreen extends StatelessWidget {
  final int heartBPMHashCode;
  final int connectivityHashCode;

  HashCodesScreen({
    required this.heartBPMHashCode,
    required this.connectivityHashCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hash Codes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'HeartBPM Hash Code:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$heartBPMHashCode',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Connectivity Hash Code:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$connectivityHashCode',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

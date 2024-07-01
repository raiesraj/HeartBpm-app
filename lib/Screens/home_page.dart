import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  bool isBPMEnabled = false;

  num get minBPM =>
      bpmValues.isNotEmpty ? bpmValues.map((e) => e.value).reduce((a, b) => a < b ? a : b) : 0;

  num get maxBPM =>
      bpmValues.isNotEmpty ? bpmValues.map((e) => e.value).reduce((a, b) => a > b ? a : b) : 0;

  double get avgBPM {
    if (bpmValues.isEmpty) return 0.0;
    double sum = bpmValues.map((e) => e.value).reduce((a, b) => a + b).toDouble();
    return sum / bpmValues.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Heart BPM Security', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Example Lottie animation in AppBar
          Lottie.asset(
            'assets/animations/heartbeat.json', // Adjust path to your animation
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 16),
          // Placeholder for connectivity status icon

          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  if (isBPMEnabled)
                    HeartBPMDialog(
                      context: context,
                      showTextValues: true,
                      borderRadius: 10,
                      cameraWidgetWidth: MediaQuery.of(context).size.width,
                      cameraWidgetHeight: 300, // Adjust this height as needed
                      onRawData: (value) {
                        setState(() {
                          if (data.length >= 100) data.removeAt(0);
                          data.add(value);
                        });
                      },
                      onBPM: (value) {
                        setState(() {
                          if (bpmValues.length >= 100) bpmValues.removeAt(0);
                          bpmValues.add(
                            SensorValue(value: value.toDouble(), time: DateTime.now()),
                          );
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Statistics',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Cards for statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Min BPM', minBPM.toStringAsFixed(1)),
                _buildStatCard('Max BPM', maxBPM.toStringAsFixed(1)),
                _buildStatCard('Avg BPM', avgBPM.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.favorite_rounded),
              label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isBPMEnabled ? Colors.red : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  isBPMEnabled = !isBPMEnabled;
                  if (!isBPMEnabled) {
                    // Stop capturing data and clear lists if needed
                    data.clear();
                    bpmValues.clear();
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/graph',
                    arguments: {'data': data, 'bpmValues': bpmValues});
              },
              child: const Text('Graph'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:crypto/crypto.dart'; // For hashing
import 'dart:convert';

import 'package:lottie/lottie.dart'; // For utf8.encode

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<SensorValue> data = args['data'] ?? [];
    List<SensorValue> bpmValues = args['bpmValues'] ?? [];

    // Calculate hash codes
    String dataHash = calculateHash(data);
    String bpmHash = calculateHash(bpmValues);

    bool isEmpty = data.isEmpty && bpmValues.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          // Example Lottie animation in AppBar
          Lottie.asset(
            'assets/animations/heartbeat.json', // Adjust path to your animation
            height: 50,
            width: 50,
          ),
          SizedBox(width: 16),
          // Placeholder for connectivity status icon

          SizedBox(width: 16),
        ],
centerTitle: true,
        title: const Text('Graphs', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEmpty
            ? const Center(
          child: Text(
            'Measure Bpm First.',
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        )
            : Column(
          children: [
            if (data.isNotEmpty)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      const BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: BPMChart(data), // Use BPMChart widget for data
                ),
              ),
            if (bpmValues.isNotEmpty)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      const BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: BPMChart(bpmValues), // Use BPMChart widget for bpmValues
                ),
              ),
            // Display the hash codes
            if (data.isNotEmpty || bpmValues.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(top: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hash Codes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      if (data.isNotEmpty) // Display only if data is present
                        Text(
                          'Connectivity Data Hash: $dataHash',
                          style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                      const SizedBox(height: 10),
                      if (bpmValues.isNotEmpty) // Display only if BPM values are present
                        Text(
                          'Heart BPM Data Hash: $bpmHash',
                          style: const TextStyle(fontSize: 16, color: Colors.greenAccent),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Utility function to calculate the hash code of a list of SensorValue
  String calculateHash(List<SensorValue> values) {
    if (values.isEmpty) return "No Data";

    // Convert SensorValues to a string representation
    String valuesString = values.map((e) => e.value.toString()).join(",");

    // Convert to bytes
    var bytes = utf8.encode(valuesString);

    // Compute the hash using MD5
    var digest = md5.convert(bytes);

    // Return the hash as a hexadecimal string
    return digest.toString();
  }
}

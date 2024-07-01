import 'package:byte_stream/Screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/graph_screen.dart';
import 'Screens/home_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart BPM Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: StartScreen(),
      routes: {
        '/graph': (context) => GraphScreen(),
      },
    );
  }
}

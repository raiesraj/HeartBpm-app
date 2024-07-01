import 'package:byte_stream/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                  width: 200,
                ),
                Text(
                  'Encrypt Heart Rate',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),

                SizedBox(
                  width: 270, // Set the desired width for the button
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadowColor: Colors.black,
                        elevation: 5,
                      ),
                      child: Text(
                        'Start',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_note/constant/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note,
              size: 60,
              color: draculaWhite,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Simple',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: draculaPurple
                  ),
                ),
                Text('Note',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: draculaPink
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 120,
              child: LinearProgressIndicator(
                backgroundColor: draculaGrey,
                color: draculeOrange,
              ),
            )
          ],
        )
      ),
    );
  }
}
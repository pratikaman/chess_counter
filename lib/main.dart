import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(ChessCounterApp());
}

class ChessCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChessCounterHome(),
    );
  }
}

class ChessCounterHome extends StatefulWidget {
  @override
  _ChessCounterHomeState createState() => _ChessCounterHomeState();
}

class _ChessCounterHomeState extends State<ChessCounterHome> {
  int player1Time = 600; // 10 minutes in seconds
  int player2Time = 600;
  Timer? timer;
  bool isPlayer1Turn = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (isPlayer1Turn) {
          if (player1Time > 0) player1Time--;
        } else {
          if (player2Time > 0) player2Time--;
        }
      });
    });
  }

  void switchPlayer() {
    setState(() {
      isPlayer1Turn = !isPlayer1Turn;
    });
  }

  void resetTimer() {
    setState(() {
      player1Time = 600;
      player2Time = 600;
      isPlayer1Turn = true;
      timer?.cancel();
    });
  }

  String formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                if (isPlayer1Turn) switchPlayer();
                if (timer == null || !timer!.isActive) startTimer();
              },
              child: Container(
                width: double.infinity,
                height: 200,
                color: isPlayer1Turn ? Colors.blue[100] : Colors.blue[50],
                child: Center(
                  child: Text(
                    formatTime(player1Time),
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!isPlayer1Turn) switchPlayer();
                if (timer == null || !timer!.isActive) startTimer();
              },
              child: Container(
                width: double.infinity,
                height: 200,
                color: !isPlayer1Turn ? Colors.red[100] : Colors.red[50],
                child: Center(
                  child: Text(
                    formatTime(player2Time),
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: resetTimer,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
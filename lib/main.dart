// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import "dart:async";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StopWatchTimerApp(),
    );
  }
}

class StopWatchTimerApp extends StatefulWidget {
  const StopWatchTimerApp({Key? key}) : super(key: key);

  @override
  State<StopWatchTimerApp> createState() => _StopWatchTimerApp();
}

class _StopWatchTimerApp extends State<StopWatchTimerApp> {
  ///////////////////////////////////////////////////////dart
  Duration duration = Duration(minutes: 25);
  // int NewSecond = duration.inSeconds;  //wrong
  Timer? repeatedFunction; // null safety

  bool isNotRunning = true;

  starTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int NewSecond = duration.inSeconds - 1;
        duration = Duration(seconds: NewSecond);
        if (NewSecond == 0) {
          repeatedFunction!.cancel();
          duration = Duration(minutes: 25);
          isNotRunning = true;
        }
      });
    });
  }

  ///////////////////////////////////////////////////////flutter
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promomdoro App",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 50, 65, 71),
      ),
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 120.0,
                progressColor: Color.fromARGB(255, 255, 85, 113),
                backgroundColor: Colors.grey,
                lineWidth: 8.0,
                percent: duration.inMinutes/25,   // 0 - 1 
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,  // 1000 = 1 second then 60000= 1 minutes
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: TextStyle(
                    fontSize: 77,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 33,
          ),
          (isNotRunning)
              ? ElevatedButton(
                  onPressed: () {
                    starTimer();
                    isNotRunning = false;
                    // to return the app run after finish when clicked again
                  },
                  child: Text(
                    "Start Study ",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 25, 120, 197)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // repeatedFunction!.cancel();
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          starTimer();
                        }
                        // to return the app run after finish when clicked again
                      },
                      child: Text(
                        (repeatedFunction!.isActive) ? "Stop" : "Resume",
                        style: TextStyle(
                            fontSize: 27,
                            color: Color.fromARGB(236, 155, 38, 38)),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 25, 120, 197)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          repeatedFunction!.cancel();
                          duration = Duration(minutes: 25);
                          isNotRunning = true;
                        });
                        // to return the app run after finish when clicked again
                      },
                      child: Text(
                        "  Cancel  ",
                        style: TextStyle(
                            fontSize: 27,
                            color: Color.fromARGB(236, 155, 38, 38)),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 25, 120, 197)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

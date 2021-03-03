import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_app1/bird.dart';
import 'bird.dart';
import 'barriers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  double score = 0;
  double best = 0;
  double hScreen = 0;
  double wScreen = -1;
   

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    birdYaxis = 0;
    time = 0;
    height = 0;
    initialHeight = birdYaxis;
    barrierXone = 1;
    barrierXtwo = barrierXone + 1.5;
    score = 0;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
        score += 1;
        if(wScreen <0 ){
          wScreen = MediaQuery.of(context).size.width;
          hScreen = MediaQuery.of(context).size.height;
        }
      });

      setState(() {
        if (barrierXone < -1.1) {
          barrierXone += 2.2;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -1.1) {
          barrierXtwo += 2.2;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1.0) {
        timer.cancel();
        gameHasStarted = false;
        if (score > best) {
          best = score;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(microseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text('')
                          : Text(
                              'TAP TO PLAY$wScreen $hScreen',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        200.0,
                      ),
                    )
                  ],
                )),
            Container(
              height: 10,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'score',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('$score',
                            style: TextStyle(color: Colors.white, fontSize: 30))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('best',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('$best',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     if (gameHasStarted) {
                    //     } else {}
                    //   },
                    //   child: Text(
                    //     'restart',
                    //     style: TextStyle(color: Colors.white, fontSize: 20),
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

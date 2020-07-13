import 'package:sottimer/services/Food.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:audioplayers/audio_cache.dart';


class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {

  Food toCook = new Food();
  AnimationController _controller;
  int startTime;
  String foodState = "raw";
  static AudioCache player = new AudioCache();

  String get timerString {
    if (foodState == "burnt") {
      return "0:00";
    }
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    Duration timeLeft = new Duration(milliseconds: toCook.cookingTime*1000 - (currentTime - startTime));
    return '${timeLeft.inMinutes}:${(timeLeft.inSeconds % 60)
        .toString()
        .padLeft(2, '0')}';
  }

  String get cookingState {
    if (foodState == "burnt") {
      return "Shiver me timbers, the ${toCook.name} is burnt!";
    } else if (foodState == "raw") {
      return 'Cooking ${toCook.name}...';
    } else if (foodState == "cooked"){
      return '${toCook.name} is cooked, get it before it burns!';
    }
  }

  double get timerRemaining {
    if (foodState == "burnt") {
      return 0;
    }
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    double timeLeft = (currentTime - startTime) / (toCook.cookingTime-1) / 1000;
    if (timeLeft >= 1) {
      if (foodState == "raw") {
        foodState = "cooked";
        startTime = startTime + toCook.cookingTime * 1000;
        player.play("sfx_ai_chicken_call_01.wav");
      } else if (foodState == "cooked") {
        foodState = "burnt";
      }
    }
    return timeLeft;
  }

  Color get timerColor {
    if (foodState == "raw") {
      return Color(0xFF48BFF6);
    }
    return Color(0xFFFEFD000);
  }

  Color get timerBackgroundColor {
    if (foodState == "burnt") {
      return Color(0xFF720819);
    }
    return Color(0xFF031010);
  }

  @override
  void initState(){
    super.initState();
    startTime = new DateTime.now().millisecondsSinceEpoch;
    _controller = AnimationController(
      vsync: this,
    );
    Wakelock.enable();
  }

  @override
  void dispose() {
    _controller.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    toCook = ModalRoute
      .of(context)
      .settings
      .arguments;

    _controller.duration = Duration(seconds:toCook.cookingTime*2);
    _controller.reverse(from: toCook.cookingTime.toDouble()*2);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff031010),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.clear),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: Text(
                              '$cookingState',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white70,
                                letterSpacing: 2,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(
                                    value: timerRemaining,
                                    backgroundColor: timerBackgroundColor,
                                    valueColor: new AlwaysStoppedAnimation<Color>(timerColor),
                                    strokeWidth: 20,
                                  ),
                                height: 250.0,
                                width: 250.0,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                    'assets/${toCook.iconUrl}',
                                    fit: BoxFit.cover
                                ),
                              )
                            ]
                          ),
                          height: 250.0,
                          width: 250.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 60),
                            child: Text(
                              '$timerString',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white70,
                                letterSpacing: 2,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]
        ),
      ),
    );
  }
}

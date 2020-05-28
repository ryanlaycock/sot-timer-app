import 'package:sottimer/services/Food.dart';
import 'package:flutter/material.dart';


class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {

  Food toCook = new Food();
  AnimationController _controller;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    if (duration.inSeconds >= toCook.cookingTime) {
      duration -= Duration(seconds: toCook.cookingTime);
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60)
        .toString()
        .padLeft(2, '0')}';
  }

  String get cookingState {
    Duration duration = _controller.duration * _controller.value;
    if (duration.inSeconds == 0) {
      return "Shiver me timbers, the ${toCook.name} is burnt!";
    } else if (duration.inSeconds >= toCook.cookingTime) {
      return '${toCook.name} is cooking...';
    } else if (duration.inSeconds <= toCook.cookingTime){
      return '${toCook.name} is cooked, get it before it burns!';
    }
  }

  double get timerRemaining {
    Duration duration = _controller.duration * _controller.value;
    if (duration.inSeconds > toCook.cookingTime.toDouble()) {
      return (toCook.cookingTime*2 - duration.inSeconds)/ toCook.cookingTime;
    }
    return duration.inSeconds / toCook.cookingTime;
  }

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.cancel),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(
                                    value: timerRemaining,
                                  ),
                                height: 200.0,
                                width: 200.0,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$timerString',
                                  style: TextStyle(
                                    color: Colors.amberAccent[200],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              )
                            ]
                          ),
                          height: 200.0,
                          width: 200.0,
                        ),
                        Text(
                          '$cookingState',
                          style: TextStyle(
                            color: Colors.amberAccent[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
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

import 'package:flutter/material.dart';
import 'package:sottimer/pages/home.dart';
import 'package:sottimer/pages/timer.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/timer': (context) => Timer(),
    }
));
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:time_tracking/pages/timer/timer_page.dart';

part 'main.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const MyApp());
}

@hwidget
Widget myApp() {
  useState(0);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const TimerPage(),
  );
}

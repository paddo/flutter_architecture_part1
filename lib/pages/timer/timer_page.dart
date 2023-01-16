import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';
import 'package:time_tracking/pages/timer/timer_page_model.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'timer_page.g.dart';

@hwidget
Widget timerPage() {
  final model = useMemoized(() => TimerPageModel(speedMultiplier: 50));
  final shortestSide = MediaQuery.of(useContext()).size.shortestSide;
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: shortestSide * 0.55,
            height: shortestSide * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(shortestSide * 0.4),
              color: const Color(0xFF363E66),
            ),
          ),
          ProgressIndicator(model.seconds, shortestSide * 0.6, shortestSide * 0.05, const Color(0xFF859DC1)),
          ProgressIndicator(model.minutes, shortestSide * 0.7, shortestSide * 0.05, const Color(0xFF82BDBF)),
          ProgressIndicator(model.hours, shortestSide * 0.8, shortestSide * 0.05, const Color(0xFFB8D6E1)),
          TimerText(model.duration),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(color: Colors.green, onPressed: () => model.start(), child: const Text('Start')),
          MaterialButton(color: Colors.redAccent, onPressed: () => model.stop(), child: const Text('Stop')),
          MaterialButton(color: Colors.blueAccent, onPressed: () => model.reset(), child: const Text('Reset')),
        ],
      ),
    ],
  );
}

@hwidget
Widget progressIndicator(BehaviorSubject<double> subject, double diameter, double strokeWidth, Color color) => SizedBox(
      height: diameter,
      width: diameter,
      child: CircularProgressIndicator(
        value: useStream(subject).data ?? 0.0,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );

@hwidget
Widget timerText(BehaviorSubject<Duration> subject) {
  final duration = useStream(subject).data ?? Duration.zero;
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

  return Text(
    '$hours:$minutes:$seconds',
    style: Theme.of(useContext()).textTheme.headline1,
  );
}

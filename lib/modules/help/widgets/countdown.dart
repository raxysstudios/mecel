import 'dart:async';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  const Countdown({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext, Duration) builder;

  @override
  CountdownState createState() => CountdownState();
}

class CountdownState extends State<Countdown> {
  late final Timer timer;
  late var duration = Duration.zero;

  @override
  void initState() {
    final now = DateTime.now().toUtc();
    final tomorrow = DateTime(now.year, now.month, now.day).add(
      const Duration(days: 1),
    );
    duration = tomorrow.difference(now);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) => decrementSecond(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void decrementSecond() {
    duration = Duration(seconds: duration.inSeconds - 1);
    if (duration.isNegative) {
      duration = const Duration(
        hours: 23,
        minutes: 59,
        seconds: 59,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, duration);
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BPM Tap',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double avgbpm = 0.0;
  int n = 0;
  int lastTap = 0;
  double newbpm = 0.0;

  void _tap() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (lastTap != 0) {
      n += 1;
      int d = now - lastTap;
      newbpm = 1000 * 60 / d;
      setState(() {
        avgbpm += (newbpm - avgbpm) / n;
      });
    }
    lastTap = now;
  }

  void _reset() {
    setState(() {
      avgbpm = 0.0;
      lastTap = 0;
      newbpm = 0.0;
      n = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _tap,
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            Text(newbpm.toStringAsFixed(2),
                style: TextStyle(fontSize: 42, color: Colors.white)),
            Spacer(),
            Text('$n', style: TextStyle(fontSize: 42, color: Colors.white)),
          ]),
          Spacer(),
          Text(avgbpm.toStringAsFixed(2),
              style: TextStyle(fontSize: 72, color: Colors.white)),
          Spacer(),
          Spacer(),
          TextButton(
            onPressed: _reset,
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(72),
              backgroundColor: Colors.white,
              splashFactory: NoSplash.splashFactory,
            ),
            child: new Text('Reset',
                style: TextStyle(fontSize: 26, color: Colors.black)),
          ),
        ]));
  }
}

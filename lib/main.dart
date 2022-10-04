import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

main() => runApp(MyApp());

class MyApp extends HookWidget {
  @override
  Widget build(context) {
    final avgbpm = useState(0.0);
    final n = useState(0);
    final lastTap = useState(0);
    final newbpm = useState(0.0);

    void _tap() {
      int now = DateTime.now().millisecondsSinceEpoch;
      if (lastTap.value != 0) {
        n.value += 1;
        int d = now - lastTap.value;
        newbpm.value = 1000 * 60 / d;
        avgbpm.value += (newbpm.value - avgbpm.value) / n.value;
      }
      lastTap.value = now;
    }

    void _reset() {
      avgbpm.value = 0.0;
      lastTap.value = 0;
      newbpm.value = 0.0;
      n.value = 0;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child:TextButton(
        onPressed: _tap,
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            Text(newbpm.value.toStringAsFixed(2),
                style: TextStyle(fontSize: 42, color: Colors.white)),
            Spacer(),
            Text('${n.value}', 
                style: TextStyle(fontSize: 42, color: Colors.white)),
          ]),
          Spacer(),
          Text(avgbpm.value.toStringAsFixed(2),
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
            child: Text('Reset',
              style: TextStyle(fontSize: 26, color: Colors.black)),
          ),
        ])));
  }
}

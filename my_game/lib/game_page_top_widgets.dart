import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TopWidgets extends StatelessWidget {
  const TopWidgets({super.key, required this.time, required this.count});
  final String time;
  final int count;
  static const TextStyle textStyle = TextStyle(color: Colors.amber,fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Text('Time elapsed',style: textStyle,),
            ),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(time,style: textStyle,),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Text('Moves count',style: textStyle,),
            ),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text('$count',style: textStyle,),
            ),
          ],
        ),
      ],
    );
  }
}

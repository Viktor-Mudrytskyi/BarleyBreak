import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_game/player_model.dart';

class Scores extends StatelessWidget {
  const Scores({super.key});
  static final box = Hive.box('Winners');
  static const TextStyle textStyle =
      TextStyle(color: Colors.amber, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winners'),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          //   children: const [
          //     //SizedBox(width: 21.0,),
          //     Text(
          //       'Name',
          //       style: TextStyle(color: Colors.amber, fontSize: 20.0),
          //     ),
          //     //SizedBox(width: 11.0,),
          //     Text(
          //       'Time',
          //       style: TextStyle(color: Colors.amber, fontSize: 20.0),
          //     ),
          //     Text(
          //       'Moves',
          //       style: TextStyle(color: Colors.amber, fontSize: 20.0),
          //     ),
          //     Text(
          //       'Size',
          //       style: TextStyle(color: Colors.amber, fontSize: 20.0),
          //     ),
          //   ],
          // ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    nameColumn(),
                    timeColumn(),
                    movesColumn(),
                    sizeColumn(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column nameColumn() {
    List<Text> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(Text(
        (box.getAt(i) as Winner).name,
        style: textStyle,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Column timeColumn() {
    List<Text> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(Text(
        (box.getAt(i) as Winner).time,
        style: textStyle,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Column movesColumn() {
    List<Text> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(Text(
        '${(box.getAt(i) as Winner).moves}',
        style: textStyle,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Column sizeColumn() {
    List<Text> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(Text(
        (box.getAt(i) as Winner).size,
        style: textStyle,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }
}

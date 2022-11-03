import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_game/game_page_top_widgets.dart';
import 'package:my_game/player_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.number});
  final int number;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<ElevatedButton> butts = [];
  List<String> values = [];
  final TextEditingController textEditingController = TextEditingController();
  String winnerName = '';
  int seconds = 0;
  late Timer timer;
  ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[850],
  );

  static const TextStyle textStyle = TextStyle(color: Colors.amber);

  late final int crossNumber;
  late final int length;
  int movesCount = 0;
  late Function isWinning = () {};

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    textEditingController.dispose();
    print('disposed');
  }

  void onPress(int id) {
    if (id < length - 1) {
      if (id % crossNumber != crossNumber - 1 && values[id + 1] == '_') {
        butts[id] = ElevatedButton(
          onPressed: () => onPress(id),
          style: style,
          child: Text(
            values[id + 1],
            style: textStyle,
          ),
        );
        butts[id + 1] = ElevatedButton(
          onPressed: () => onPress(id + 1),
          style: style,
          child: Text(
            values[id],
            style: textStyle,
          ),
        );
        String sr = values[id + 1];
        values[id + 1] = values[id];
        values[id] = sr;
        setState(() {
          movesCount++;
          butts = butts.toList();
          if (isWinning() ?? false) {
            winningSheet();
          }
        });
      }
    }
    if (id < length - crossNumber) {
      if (values[id + crossNumber] == '_') {
        butts[id] = ElevatedButton(
          onPressed: () => onPress(id),
          style: style,
          child: Text(
            values[id + crossNumber],
            style: textStyle,
          ),
        );
        butts[id + crossNumber] = ElevatedButton(
          onPressed: () => onPress(id + crossNumber),
          style: style,
          child: Text(
            values[id],
            style: textStyle,
          ),
        );
        String sr = values[id + crossNumber];
        values[id + crossNumber] = values[id];
        values[id] = sr;
        setState(() {
          movesCount++;
          butts = butts.toList();
          if (isWinning() ?? false) {
            winningSheet();
          }
        });
      }
    }
    if (id >= crossNumber) {
      if (values[id - crossNumber] == '_') {
        butts[id] = ElevatedButton(
          onPressed: () => onPress(id),
          style: style,
          child: Text(
            values[id - crossNumber],
            style: textStyle,
          ),
        );
        butts[id - crossNumber] = ElevatedButton(
          onPressed: () => onPress(id - crossNumber),
          style: style,
          child: Text(
            values[id],
            style: textStyle,
          ),
        );
        String sr = values[id - crossNumber];
        values[id - crossNumber] = values[id];
        values[id] = sr;
        setState(() {
          movesCount++;
          butts = butts.toList();
          if (isWinning() ?? false) {
            winningSheet();
          }
        });
      }
    }
    if (id > 0) {
      if (id % crossNumber != 0 && values[id - 1] == '_') {
        butts[id] = ElevatedButton(
          onPressed: () => onPress(id),
          style: style,
          child: Text(
            values[id - 1],
            style: textStyle,
          ),
        );
        butts[id - 1] = ElevatedButton(
          onPressed: () => onPress(id - 1),
          style: style,
          child: Text(
            values[id],
            style: textStyle,
          ),
        );
        String sr = values[id - 1];
        values[id - 1] = values[id];
        values[id] = sr;
        setState(() {
          movesCount++;
          butts = butts.toList();
          if (isWinning() ?? false) {
            winningSheet();
          }
        });
      }
    }
  }

  void createButts() {
    for (int i = 0; i < length - 1; i++) {
      butts.add(
        ElevatedButton(
          onPressed: () {
            onPress(i);
          },
          style: style,
          child: Text('${i + 1}', style: textStyle),
        ),
      );
      values.add('${i + 1}');
    }
    butts.add(ElevatedButton(
        onPressed: () {
          onPress(length - 1);
        },
        style: style,
        child: const Text('_', style: textStyle)));
    values.add('_');
  }

  void randList() {
    for (int i = 0; i < crossNumber * crossNumber * 10; i++) {
      int id = values.indexOf('_');
      switch (Random().nextInt(4)) {
        case 0:
          {
            if (id < length - 1) {
              id += 1;
              onPress(id);
            }
          }
          break;
        case 1:
          {
            if (id > 0) {
              id -= 1;
              onPress(id);
            }
          }
          break;
        case 2:
          {
            if (id < length - crossNumber) {
              id += crossNumber;
              onPress(id);
            }
          }
          break;
        case 3:
          {
            if (id > crossNumber) {
              id -= crossNumber;
              onPress(id);
            }
          }
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    crossNumber = widget.number;
    length = widget.number * widget.number;
    createButts();
    randList();
    movesCount = 0;
    textEditingController.addListener(() {
      winnerName = textEditingController.text;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          seconds++;
        });
      },
    );

    isWinning = () {
      for (int i = 0; i < length - 1; i++) {
        if (values[i] != '${i + 1}') {
          return false;
        }
      }
      return true;
    };
  }

  void winningSheet() {
    timer.cancel();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(color: Colors.grey.shade900),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'You won',
                  style: TextStyle(fontSize: 25.0, color: Colors.amber),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                  child: TextField(
                    style: const TextStyle(color: Colors.amber),
                    maxLength: 10,
                    scrollPhysics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    autofocus: true,
                    controller: textEditingController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        label: Text(
                          'Enter your name',
                          style: TextStyle(color: Colors.amber),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        var box = Hive.box('Winners');
                        if (winnerName.isNotEmpty) {
                          box.add(Winner(
                              name: winnerName,
                              time: timeToString(seconds),
                              moves: movesCount,
                              size: '$crossNumber×$crossNumber'));
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  String timeToString(int seconds) {
    String m =
        (seconds / ~60 < 10) ? "0${seconds ~/ 60}" : (seconds / ~60).toString();
    String s =
        (seconds % 60 < 10) ? "0${seconds % 60}" : (seconds % 60).toString();
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('$crossNumber×$crossNumber'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          TopWidgets(time: timeToString(seconds), count: movesCount),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: GridView.count(
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              crossAxisCount: crossNumber,
              children: butts,
            ),
          ),
        ],
      ),
    );
  }
}

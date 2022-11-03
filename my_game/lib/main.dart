import 'package:flutter/material.dart';
import 'package:my_game/game_page.dart';
import 'package:my_game/levels.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_game/player_model.dart';
import 'package:my_game/scores_page.dart';

void main() async{
  await Hive.initFlutter('Scores');
  Hive.registerAdapter(WinnerAdapter());
  var box = await Hive.openBox('Winners');
  
  runApp(
    MaterialApp(
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/levels': (context) => const Levels(),
        '/game5': (context) => GamePage(number: 5),
        '/game6': (context) => GamePage(number: 6),
        '/game7': (context) => GamePage(number: 7),
        '/scores':(context) => Scores(),
      },
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text("Barley Break"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/levels');
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(100.0,0,100.0,0),
                child: Text('Play',style: TextStyle(color: Colors.amber),),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/scores');
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(93.0,0,93.0,0),
                child: Text('Scores',style: TextStyle(color: Colors.amber),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

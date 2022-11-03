import 'package:hive_flutter/hive_flutter.dart';
part 'player_model.g.dart';

@HiveType(typeId: 1)
class Winner {
  Winner(
      {required this.name,
      required this.time,
      required this.moves,
      required this.size});
  @HiveField(0)
  String name;

  @HiveField(1)
  String time;

  @HiveField(2)
  int moves;

  @HiveField(3)
  String size;
}

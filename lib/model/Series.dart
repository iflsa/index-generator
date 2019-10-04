import 'package:hive/hive.dart';

part 'Series.g.dart';

@HiveType()
class Series {
  @HiveField(0)
  String name;
  @HiveField(2)
  List<String> used;
  @HiveField(3)
  String model;

  Series(this.name, this.model, {this.used = const []});
}

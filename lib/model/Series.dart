import 'package:hive/hive.dart';

part 'Series.g.dart';

@HiveType()
class Series {
  @HiveField(0)
  String name;
  @HiveField(1)
  int digitsNumber;
  @HiveField(2)
  List<String> used;

  Series(this.name, this.digitsNumber, {this.used = const []});
}

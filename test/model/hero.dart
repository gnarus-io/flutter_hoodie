import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hero.g.dart';

@JsonSerializable()
class Hero extends MutableDocument {
  Hero({
    this.name,
    this.gender,
    this.eyeColor,
    this.race,
    this.hairColor,
    this.height,
    this.publisher,
    this.skinColor,
    this.alignment,
    this.id,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => _$HeroFromJson(json);

  String alignment;
  String eyeColor;
  String gender;
  String hairColor;
  double height;
  String id;
  String name;
  String publisher;
  String race;
  String skinColor;

  Map<String, dynamic> toJson() => _$HeroToJson(this);
}

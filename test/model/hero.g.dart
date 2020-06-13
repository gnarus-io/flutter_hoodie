// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hero _$HeroFromJson(Map<String, dynamic> json) {
  return Hero(
    name: json['name'] as String,
    gender: json['gender'] as String,
    eyeColor: json['eyeColor'] as String,
    race: json['race'] as String,
    hairColor: json['hairColor'] as String,
    height: (json['height'] as num)?.toDouble(),
    publisher: json['publisher'] as String,
    skinColor: json['skinColor'] as String,
    alignment: json['alignment'] as String,
  );
}

Map<String, dynamic> _$HeroToJson(Hero instance) => <String, dynamic>{
      'alignment': instance.alignment,
      'eyeColor': instance.eyeColor,
      'gender': instance.gender,
      'hairColor': instance.hairColor,
      'height': instance.height,
      'name': instance.name,
      'publisher': instance.publisher,
      'race': instance.race,
      'skinColor': instance.skinColor,
    };

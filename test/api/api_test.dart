import 'package:flutter_hoodie/flutter_hoodie.dart';
import 'package:test/test.dart';

import '../model/hero.dart';
import 'api_test_store.dart';

void main() {
  Store store;

  setUpAll(() async {
    store = ApiTestStore();
  });
  test('Store should initialize', () {});

  test('Store should sync', () async {
    await store.sync();
  });

  test('Store should add a single entity from properties', () async {
    Map<String, dynamic> document = {
      'name': 'A-Bomb',
      'gender': 'Male',
      'eyeColor': 'yellow',
      'race': 'Human',
      'hairColor': 'No Hair',
      'height': 203.0,
      'publisher': 'Marvel Comics',
      'skinColor': null,
      'alignment': 'good'
    };

    document = await store.add(document);

    expect(document['id'], isNotNull);
    expect(document['id'], isNotEmpty);
  });

  test('Store should add a single entity from a document subclass', () async {
    Hero document = Hero(
      name: 'A-Bomb',
      gender: 'Male',
      eyeColor: 'yellow',
      race: 'Human',
      hairColor: 'No Hair',
      height: 203.0,
      publisher: 'Marvel Comics',
      skinColor: null,
      alignment: 'good',
    );

    document = await store.add(document);

    expect(document.id, isNotNull);
    expect(document.id, isNotEmpty);
  });

  test('Store should add multiple entities', () async {
    var documents = [
      Hero(
        name: 'A-Bomb',
        gender: 'Male',
        eyeColor: 'yellow',
        race: 'Human',
        hairColor: 'No Hair',
        height: 203.0,
        publisher: 'Marvel Comics',
        skinColor: null,
        alignment: 'good',
      ),
      Hero(
        name: 'Abe Sapien',
        gender: 'Male',
        eyeColor: 'blue',
        race: 'Icthyo Sapien',
        hairColor: 'No Hair',
        height: 191.0,
        publisher: 'Dark Horse Comics',
        skinColor: 'blue',
        alignment: 'good',
      ),
    ];

    await store.addAll(documents);

    expect(documents.length, equals(2));

    for (final document in documents) {
      expect(document.id, isNotNull);
      expect(document.id, isNotEmpty);
    }
  });
}

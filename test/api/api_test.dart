import 'package:flutter_hoodie/flutter_hoodie.dart';
import 'package:mockito/mockito.dart';
import 'package:quiver/check.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../model/hero.dart';

class MockStore extends Mock implements Store {}

void main() {
  Store store;

  setUpAll(() async {
    store = MockStore();

    when(store.add(any)).thenAnswer((it) async {
      final document = it.positionalArguments.first;

      checkNotNull(
        document,
        message: 'Argument cannot be null (document)',
      );

      document["id"] = Uuid().v4();
    });

    when(store.addAll(any)).thenAnswer((it) async {
      final documents = it.positionalArguments.first;

      checkArgument(
        documents != null && documents.isNotEmpty,
        message: 'Argument cannot be null or empty (documents)',
      );

      for (final document in documents) {
        checkState(
          document != null,
          message: 'Documents cannot contain null entries',
        );

        document['id'] = Uuid().v4();
      }

      return documents;
    });

    when(store.find('existing-id')).thenAnswer((it) async {
      String id = it.positionalArguments.first;

      checkNotNull(
        id,
        message: 'Argument cannot be null (id)',
      );

      int now = DateTime.now().millisecondsSinceEpoch;

      return {
        'id': id,
        'createdAt': now - 100,
        'updatedAt': now,
        'data': 'data',
      };
    });
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

    await store.add(document);

    expect(document['id'], isNotNull);
    expect(document['id'], isNotEmpty);
  });

  test('Store should add a single entity from a model object', () async {
    Hero hero = Hero(
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

    Map<String, dynamic> document = hero.toJson();

    await store.add(document);

    expect(document['id'], isNotNull);
    expect(document['id'], isNotEmpty);
  });

  test('Store should add multiple entities', () async {
    List<Map<String, dynamic>> documents = [
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
      ).toJson(),
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
      ).toJson(),
    ];

    await store.addAll(documents);

    expect(documents.length, equals(2));

    for (final document in documents) {
      expect(document['id'], isNotNull);
      expect(document['id'], isNotEmpty);
    }
  });

  test('Store should find document by id', () async {
    Map<String, dynamic> document = await store.find('existing-id');

    expect(document['id'], 'existing-id');
    expect(document['createdAt'], isNotNull);
    expect(document['createdAt'], greaterThan(0));
    expect(document['updatedAt'], isNotNull);
    expect(document['updatedAt'], greaterThanOrEqualTo(document['createdAt']));
  });
}

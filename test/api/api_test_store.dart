import 'package:flutter_hoodie/flutter_hoodie.dart';
import 'package:quiver/check.dart';
import 'package:uuid/uuid.dart';

class ApiTestStore implements Store {
  @override
  Future<dynamic> add(dynamic document) async {
    checkNotNull(
      document,
      message: 'Argument cannot be null (document)',
    );

    if (document is Map<String, dynamic>) {
      document["id"] = Uuid().v4();
    } else {
      document.toJson();
      document.id = Uuid().v4();
    }

    return document;
  }

  @override
  Future<List<dynamic>> addAll(List<dynamic> documents) async {
    checkArgument(
      documents != null && documents.isNotEmpty,
      message: 'Argument cannot be null or empty (documents)',
    );

    for (final document in documents) {
      add(document);
    }

    return documents;
  }

  @override
  Future<void> sync() async {}
}

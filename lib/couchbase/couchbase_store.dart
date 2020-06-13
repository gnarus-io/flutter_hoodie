import 'package:couchbase_lite/couchbase_lite.dart';

import '../api/store.dart';
import 'store_options.dart';

class CouchbaseStore implements Store {
  CouchbaseStore(
    this.dbName,
    this.options,
  );

  final String dbName;
  final StoreOptions options;

  Database get _database => options.database;

  Future<void> sync() async {
    throw UnimplementedError();
  }

  Future<dynamic> add(dynamic document) async {
    await _database.saveDocument(document);
    return document;
  }

  Future<List<dynamic>> addAll(List<dynamic> documents) async {
    for (Document document in documents) {
      await _database.saveDocument(document);
    }
    return documents;
  }
}

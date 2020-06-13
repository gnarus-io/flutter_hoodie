import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:flutter/foundation.dart';
import 'package:quiver/check.dart';

class StoreOptions {
  StoreOptions({
    @required this.remote,
    @required this.database,
  }) {
    checkNotNull(
      remote,
      message: 'Argument cannot be null (remote)',
    );
    checkNotNull(
      database,
      message: 'Argument cannot be null (database)',
    );
  }

  final Database database;
  final String remote;
}

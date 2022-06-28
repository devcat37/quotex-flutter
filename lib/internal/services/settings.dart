import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quotex/domain/models/signals_data/signals_data.dart';

class Settings {
  static const String appName = 'Quotex Signal Assistant';

  static const signalsDataKey = 'signals_data';

  /// Зашифрованное хранилище локальных данных.
  late FlutterSecureStorage _storage;
  late Map<String, String> _secureValues;

  Future<void> initFirebase() async {
    await Firebase.initializeApp();
  }

  Future initStorage() async {
    _storage = const FlutterSecureStorage();
    _secureValues = await _storage.readAll();
  }

  SignalsData get signalsData =>
      (SignalsData.fromJson((jsonDecode(_secureValues[signalsDataKey] ?? '') as Map<String, dynamic>)));
  set signalsData(SignalsData data) {
    final _data = jsonEncode(data.toJson());

    _secureValues[signalsDataKey] = _data;
    _storage.write(key: signalsDataKey, value: _data);
  }
}

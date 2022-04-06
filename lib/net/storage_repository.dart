import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/net/auth_info.dart';

class StorageRepository {
  static AuthInfo? _authInfo;
  static final _storage = FlutterSecureStorage();

  static String keyAccessToken = "access_token";
  static String keyClient = "key_client";
  static String keyTokenType = "key_token_type";
  static String keyUid = "key_uid";

  static String keyUser = "user";

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  static var _box = Hive.openBox<String>('json_user');

  static Future<AuthInfo?> getAuthInfo() async {
    if (_authInfo != null) {
      return _authInfo;
    }

    var accessToken = await _storage.read(key: keyAccessToken);
    var client = await _storage.read(key: keyClient);
    var tokenType = await _storage.read(key: keyTokenType);
    var uid = await _storage.read(key: keyUid);

    var requiredValues = [accessToken, client, tokenType, uid];

    if (requiredValues.contains(null) || requiredValues.contains("")) {
      return null;
    }

    _authInfo = AuthInfo(accessToken: accessToken!, client: client!, tokenType: tokenType!, uid: uid!);

    return _authInfo;
  }

  static Future<void> storeUser(Map<String, dynamic> json) async {
    final box = await _box;
    await box.put(keyUser, jsonEncode(json));
  }

  static Future<User?> getUser() async {
    final box = await _box;
    var rawJson = box.get(keyUser);

    if (rawJson?.isEmpty ?? true) {
      return null;
    }

    Map<String, dynamic> data = json.decode(rawJson!);

    return User.fromJson(data);
  }

  static setAuthInfo(AuthInfo authInfo) async {
    _authInfo = authInfo;

    await _storage.write(key: keyAccessToken, value: authInfo.accessToken);
    await _storage.write(key: keyClient, value: authInfo.client);
    await _storage.write(key: keyTokenType, value: authInfo.tokenType);
    await _storage.write(key: keyUid, value: authInfo.uid);
  }

  static flushAuthInfo() async {
    await _storage.delete(key: keyAccessToken);
    await _storage.delete(key: keyClient);
    await _storage.delete(key: keyTokenType);
    await _storage.delete(key: keyUid);
  }

  static flushUser() async {
    var box = await _box;
    await box.delete(keyUser);
  }
}

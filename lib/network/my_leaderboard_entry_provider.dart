import 'dart:convert';

import 'package:dio/dio.dart';

import '../api.dart';
import '../model/entries.dart';
import '../model/signed_user.dart';
import '../utils/session_storage.dart';
import 'api_dio.dart';

class MyEntryProvider {
  MyEntryProvider(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<Entries> getEntries() async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'X-ZUMO-AUTH': token
    };

    final Options options = Options(headers: headers);

    final Response<dynamic> response =
        await _apiDio.dio.get(API.myEntry, options: options);

    final Map<String, dynamic> jsonData =
        jsonDecode(response.data as String) as Map<String, dynamic>;

    return Entries.fromJson(jsonData);
  }
}

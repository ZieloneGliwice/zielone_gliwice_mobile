import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/dictionary_object.dart';
import '../model/signed_user.dart';
import '../utils/session_storage.dart';
import 'api_dio.dart';

class DictionaryDataProvider {
  DictionaryDataProvider(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<List<DictionaryObject>> getData(String path) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'X-ZUMO-AUTH': token
    };

    final Options options = Options(
        headers: headers
    );

    final Response<dynamic> response = await _apiDio.dio.get(path,
        options: options);

    final List<dynamic> objects = jsonDecode(response.data as String) as List<dynamic>;
    return objects.map((dynamic json) => DictionaryObject.fromJson(json)).toList();
  }
}

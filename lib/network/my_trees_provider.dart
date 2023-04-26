import 'dart:convert';

import 'package:dio/dio.dart';

import '../api.dart';
import '../model/my_trees.dart';
import '../model/signed_user.dart';
import '../utils/session_storage.dart';
import 'api_dio.dart';

class MyTreesProvider {
  MyTreesProvider(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<MyTrees> getTrees() async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'X-ZUMO-AUTH': token
    };

    final Options options = Options(
      headers: headers
    );

    final Response<dynamic> response = await _apiDio.dio.get(API.trees,
        options: options);

    final Map<String, dynamic> jsonData = jsonDecode(response.data as String) as Map<String, dynamic>;

    return MyTrees.fromJson(jsonData);
  }
}

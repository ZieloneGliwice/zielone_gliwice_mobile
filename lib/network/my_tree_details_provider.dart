import 'dart:convert';

import 'package:dio/dio.dart';

import '../api.dart';
import '../model/signed_user.dart';
import '../model/tree_details.dart';
import '../utils/session_storage.dart';
import 'api_dio.dart';

class MyTreeDetailsProvider {
  MyTreeDetailsProvider(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<TreeDetails> getTreeDetails(String treeId) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final Map<String, String> headers = <String, String>{
      'X-ZUMO-AUTH': token
    };

    final Options options = Options(
        headers: headers,
            contentType: 'application/json'
    );

    final Response<dynamic> response = await _apiDio.dio.get('${API.trees}/$treeId',
        options: options);

    final Map<String, dynamic> jsonData = jsonDecode(response.data as String) as Map<String, dynamic>;

    return TreeDetails.fromJson(jsonData);
  }
}

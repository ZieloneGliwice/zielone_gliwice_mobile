import 'package:dio/dio.dart';

import '../api.dart';
import '../model/signed_user.dart';
import '../utils/session_storage.dart';
import 'api_dio.dart';

class MyTreeDeleteProvider {
  MyTreeDeleteProvider(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<void> deleteTree(String treeId) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final Map<String, String> headers = <String, String>{'X-ZUMO-AUTH': token};

    final Options options =
        Options(headers: headers, contentType: 'application/json');

    await _apiDio.dio.delete('${API.trees}/$treeId', options: options);
  }
}
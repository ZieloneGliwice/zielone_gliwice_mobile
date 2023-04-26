
import 'dart:convert';

import 'package:dio/dio.dart';

import '../api.dart';
import '../model/new_tree.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../utils/session_storage.dart';

class NewTreeRequest {
  NewTreeRequest(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<NewTree> createTree(NewTree newTree, ProgressCallback progress) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final FormData body = await newTree.toFormData();

    final Map<String, String> headers = <String, String>{
      'X-ZUMO-AUTH': token,
    };

    final Options options = Options(
        contentType: 'application/json',
        headers: headers
    );

    await _apiDio.dio.post(API.trees, data: body, options: options, onSendProgress: progress);
    return newTree;
  }
}

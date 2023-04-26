import 'dart:convert';

import 'package:dio/dio.dart';

import '../api.dart';
import '../model/session.dart';
import '../network/api_dio.dart';

class SocialAuthenticationProvider {
  SocialAuthenticationProvider(this._apiDio);

  final ApiDio _apiDio;

  Future<Session> googleAuthenticate(String? idToken, String? authCode) async {
    return _authenticate(idToken, authCode, API.googleLoginURL);
  }

  Future<Session> appleAuthenticate(String? idToken, String? authCode) async {
    return _authenticate(idToken, authCode, API.appleLoginURL);
  }

  // POST request
  Future<Session> _authenticate(String? idToken, String? authCode, String url) async {
    final Map<String, String> data = <String, String>{
      'id_token': idToken!,
      'authorization_code': authCode!,
    };

    final Options options = Options(
      contentType: 'application/json',
      responseType: ResponseType.json
    );

    final Response<dynamic> response = await _apiDio.dio.post(url, data: jsonEncode(data), options: options);

    //final Map<String, dynamic>json = jsonDecode(response.data as String) as Map<String, dynamic>;
    return Session.fromJson(response.data as Map<String, dynamic>);
  }
}

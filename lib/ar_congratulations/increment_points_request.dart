import 'package:dio/dio.dart';

import '../analytics/analytics.dart';
import '../api.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../utils/session_storage.dart';

class IncrementPointsRequest {
  IncrementPointsRequest(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<int> incrementPoints(int points) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final FormData body = FormData.fromMap(
      <String, dynamic>{
        'points': points,
      },
    );

    final Map<String, String> headers = <String, String>{
      'X-ZUMO-AUTH': token,
    };

    final Options options =
        Options(contentType: 'application/json', headers: headers);

    await _apiDio.dio
        .post(API.leaderboardIncrementPoints, data: body, options: options);

    final String properties = body.fields
        .map((MapEntry<String, String> field) => field.key)
        .toList()
        .join(', ');
    Analytics.logEvent('Leaderboard points incremented',
        parameters: <String, String>{'properties': properties});

    return points;
  }
}

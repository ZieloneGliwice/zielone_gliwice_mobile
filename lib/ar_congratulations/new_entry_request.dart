import 'package:dio/dio.dart';

import '../analytics/analytics.dart';
import '../api.dart';
import '../model/new_entry.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../utils/session_storage.dart';

class NewEntryRequest {
  NewEntryRequest(this._sessionStorage, this._apiDio);

  final SessionStorage _sessionStorage;
  final ApiDio _apiDio;

  Future<NewEntry> createEntry(NewEntry newEntry) async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();
    final String token = signedUser?.authentication.authenticationToken ?? '';

    final FormData body = await newEntry.toFormData();

    final Map<String, String> headers = <String, String>{
      'X-ZUMO-AUTH': token,
    };

    final Options options =
        Options(contentType: 'application/json', headers: headers);

    await _apiDio.dio.post(API.createEntry, data: body, options: options);

    final String properties = body.fields
        .map((MapEntry<String, String> field) => field.key)
        .toList()
        .join(', ');
    Analytics.logEvent('Leaderboard entry created',
        parameters: <String, String>{'properties': properties});

    return newEntry;
  }
}

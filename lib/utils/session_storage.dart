import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/session.dart';
import '../model/signed_user.dart';
import '../model/user.dart';
import '../model/user_data.dart';

class SessionStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  final String _keyToken = 'token';
  final String _keyUserId = 'userId';
  final String _keyUserName = 'userName';
  final String _keyUserPhotoUrl = 'uerPhotoUrl';
  final String _keyUserEmail = 'userEmail';

  Future<void> storeSession(SignedUser signedUser) async {
    await _storage.write(key: _keyToken, value: signedUser.authentication.authenticationToken);
    await _storage.write(key: _keyUserId, value: signedUser.authentication.user?.id);
    await _storage.write(key: _keyUserName, value: signedUser.details.name);
    await _storage.write(key: _keyUserPhotoUrl, value: signedUser.details.photoUrl);
    await _storage.write(key: _keyUserEmail, value: signedUser.details.email);
  }

  Future<SignedUser?> restoreSession() async {
    final String? token = await _storage.read(key: _keyToken);
    final String? userId = await _storage.read(key: _keyUserId);
    final String? userName = await _storage.read(key: _keyUserName);
    final String? photoUrl = await _storage.read(key: _keyUserPhotoUrl);
    final String? email = await _storage.read(key: _keyUserEmail);

    if (token != null && userId != null) {
      final User user = User(id: userId);
      final Session authentication = Session(authenticationToken: token, user: user);
      final UserData details = UserData(userName, photoUrl, email);

      return SignedUser(authentication, details);
    }

    return null;
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}

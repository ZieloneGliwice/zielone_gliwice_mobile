import 'user.dart';

class Session {

  const Session({
    required this.authenticationToken,
    required this.user
  });

  factory Session.fromJson(Map<String, dynamic>? json) {
    return Session(
        authenticationToken: json?['authenticationToken'] as String,
        user: User.fromJson(json?['user'] as Map<String, dynamic>?)
    );
  }
  final String? authenticationToken;
  final User? user;
}

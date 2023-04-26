import 'session.dart';
import 'user_data.dart';

class SignedUser {
  SignedUser(this.authentication, this.details);

  final Session authentication;
  final UserData details;
}

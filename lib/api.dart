class API {
  static const String baseURL = 'https://fa-greengliwice-prod.azurewebsites.net/';
  static const String _baseAPIURL = 'api/';

  // Authorization
  static const String _baseLoginURL = '$baseURL.auth/login/';
  static const String googleLoginURL = '${_baseLoginURL}google';
  static const String facebookLoginURL = '${_baseLoginURL}facebook';
  static const String appleLoginURL = '${_baseLoginURL}apple';
  static const String appleRedirectURL = '$appleLoginURL/callback/';

  // Trees
  static const String trees = '${_baseAPIURL}users/me/trees';

  // Dictionaries
  static const String dicts = '${_baseAPIURL}dicts/';
  static const String species = '${dicts}species/';
  static const String state = '${dicts}state/';
  static const String badState = '${dicts}badState/';
}

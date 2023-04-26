class API {
  static const String baseURL = 'https://fa-greengliwice.azurewebsites.net/';
  static const String _baseAPIURL = 'api/';

  // Authorization
  static const String _baseLoginURL = '.auth/login/';
  static const String googleLoginURL = '${_baseLoginURL}google';
  static const String facebookLoginURL = '${_baseLoginURL}facebook';
  static const String appleLoginURL = '${_baseLoginURL}apple';

  // Trees
  static const String trees = '${_baseAPIURL}users/me/trees';

  // Dictionaries
  static const String dicts = '${_baseAPIURL}dicts/';
  static const String species = '${dicts}species/';
  static const String state = '${dicts}state/';
  static const String badState = '${dicts}badState/';
}

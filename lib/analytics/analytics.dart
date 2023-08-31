import 'package:firebase_analytics/firebase_analytics.dart';


abstract class Analytics {
  static void visitedScreen(String name) {
    FirebaseAnalytics.instance.logScreenView(screenName: name);
  }

  static void visitedNoDataScreen(String name) {
    FirebaseAnalytics.instance.logScreenView(screenName: '${name}_no_data');
  }

  static void visitedErrorScreen(String name) {
    FirebaseAnalytics.instance.logScreenView(screenName: '${name}_no_data');
  }

  static void buttonPressed(String title) {
    FirebaseAnalytics.instance.logEvent(name: 'button_pressed_$title');
  }

  static void loginWithGoogle() {
    FirebaseAnalytics.instance.logLogin(loginMethod: 'Google Sign In');
  }

  static void loginWithApple() {
    FirebaseAnalytics.instance.logLogin(loginMethod: 'Sign In With Apple');
  }

  static void loginFailed() {
    FirebaseAnalytics.instance.logEvent(name: 'log_in_failed');
  }

  static void logEvent(String name, {Map<String, Object>? parameters}) {
    FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }
}
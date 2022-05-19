import 'package:get/get.dart';

class ApplicationTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
    'en_US': _enUS,
    'pl_PL': _plPL
  };

  final Map<String, String> _enUS = <String, String>{
    'my_trees_title': 'My trees',
  };

  final Map<String, String> _plPL = <String, String>{
    'my_trees_title': 'Moje drzewa',
  };
}
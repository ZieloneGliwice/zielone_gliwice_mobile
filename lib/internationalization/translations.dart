import 'package:get/get.dart';

class ApplicationTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
    'en_US': _enUS,
    'pl_PL': _plPL
  };

  final Map<String, String> _enUS = <String, String>{
    'my_trees_title': 'My trees',
    'add_tree_title': 'Add tree',
    'challenges_title': 'Challenges',
    'welcome_name': 'Welcome @name!',
    'you_dont_have_tree_yet': "You don't have any added tree yet.",
    'add_your_first_tree': 'Add your first tree and help us improve green areas in our city',
    'next': 'Next',
    'reset_uppercased': 'RESET',
    'retake': 'Retake',
    'ready': 'Ready',
    'no_photo_selected': 'No photo selected',
  };

  final Map<String, String> _plPL = <String, String>{
    'my_trees_title': 'Moje drzewa',
    'add_tree_title': 'Dodaj drzewo',
    'challenges_title': 'Wyzwania',
    'welcome_name': 'Cześć @name!',
    'you_dont_have_tree_yet': 'Nie masz jeszcze dodanego żadnego drzewa.',
    'add_your_first_tree': 'Dodaj swoje pierwsze drzewo i pomóż nam poprawić stan zieleni Naszego miasta',
    'next': 'Dalej',
    'reset_uppercased': 'RESET',
    'retake': 'Powtórz',
    'ready': 'Gotowe',
    'no_photo_selected': 'Nie wybrano zdjęcia',
  };
}

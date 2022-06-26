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
    'add_tree_photos_description': 'Take @mandatory_items, and optionally @optional_items',
    'add_tree_photos_description_mandatory_items': 'photos of the tree, leaf',
    'add_tree_photos_description_optional_items': 'the tree bark',
    'take_tree_photo_title': 'Take a photo of the entire tree',
    'take_tree_photo_body': 'A photo showing the crown and the tree trunk in the broadest possible perspective',
    'take_leaf_photo_title': 'Take a photo of the tree leaf',
    'take_leaf_photo_body': 'A photo with an approximately visible leaf of the tree',
    'take_bark_photo_title': 'Take a photo of the tree bark',
    'take_bark_photo_body': 'A photo showing the bark of the tree approximately',
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
    'add_tree_photos_description': 'Wykonaj kolejno @mandatory_items oraz opcjonalnie zdjęcie @optional_items',
    'add_tree_photos_description_mandatory_items': 'zdjęcia drzewa, liścia',
    'add_tree_photos_description_optional_items': 'zdjęcia drzewa, liścia',
    'take_tree_photo_title': 'Wykonaj zdjęcie całego drzewa',
    'take_tree_photo_body' : 'Zdjęcie na którym widoczna będzie korona oraz pień drzewa w możliwie w jaknajszerszej perspektywie',
    'take_leaf_photo_title': 'Wykonaj zdjęcie liścia drzewa',
    'take_leaf_photo_body': 'Zdjęcie, na którym widoczny będzie liść drzewa w przybliżeniu',
    'take_bark_photo_title': 'Wykonaj zdjęcie kory drzewa',
    'take_bark_photo_body': 'Zdjęcie, na którym widoczna będzie kora drzewa w przybliżeniu',
  };
}

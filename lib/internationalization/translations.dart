import 'package:get/get.dart';

class ApplicationTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      <String, Map<String, String>>{'en_US': _enUS, 'pl_PL': _plPL};

  final Map<String, String> _enUS = <String, String>{
    'my_trees_title': 'My trees',
    'my_tree_title': 'My Tree',
    'add_tree_title': 'Add tree',
    'challenges_title': 'Challenges',
    'welcome_name': 'Welcome @name!',
    'you_dont_have_tree_yet': "You don't have any added tree yet.",
    'add_your_first_tree':
        'Add your first tree and help us improve green areas in our city',
    'next': 'Next',
    'reset_uppercased': 'RESET',
    'retake': 'Retake',
    'ready': 'Ready',
    'no_photo_selected': 'No photo selected',
    'add_tree_photos_description_1': 'Take ',
    'add_tree_photos_description_2': 'a photo of tree, leafs ',
    'add_tree_photos_description_3': 'and optionally ',
    'add_tree_photos_description_4': 'tree bark',
    'add_tree_photos_description':
        'Take @mandatory_items, and optionally @optional_items',
    'add_tree_photos_description_mandatory_items': 'photos of the tree, leaf',
    'add_tree_photos_description_optional_items': 'the tree bark',
    'take_tree_photo_title': 'Take a photo of the entire tree',
    'take_tree_photo_body':
        'A photo showing the crown and the tree trunk in the broadest possible perspective',
    'take_leaf_photo_title': 'Take a photo of the tree leaf',
    'take_leaf_photo_body':
        'A photo with an approximately visible leaf of the tree',
    'take_bark_photo_title': 'Take a photo of the tree bark',
    'take_bark_photo_body':
        'A photo showing the bark of the tree approximately',
    'log_in_using_account': 'Sign in using account:',
    'enter_the_tree_species': 'Enter the tree species',
    'add_tree_description': 'Add a tree description',
    'add_perimeter_of_the_tree': 'Add the perimeter of the tree',
    'add_tree_state': 'Add tree state',
    'search': 'Search',
    'select': 'Select',
    'tree_description_title': 'Add tree description',
    'tree_description_explanation_1':
        'Enter a tree description below. It can be, for example, a description of its characteristics that distinguish it from other trees of the same species.',
    'tree_description_explanation_2': 'The description is optional,',
    'tree_description_explanation_3':
        'but we will be glad if you share your observations. Thanks!',
    'tree_description_hint': 'Enter description...',
    'save': 'Save',
    'add_circumference_title': 'Add the perimeter of the tree',
    'add_circumference_description_1':
        'Measure the circumference of the tree. The easiest way to measure is with',
    'add_circumference_description_2': 'a standard tape measure.',
    'add_measurement': 'Add measurement',
    'add_tree_condition': 'Add tree condition',
    'add_tree_condition_description':
        'Based on the observations, how to assess the condition of the tree?',
    'add_tree_condition_input_title': 'Can you describe the tree condition?',
    'add_tree_condition_observation_title': 'What did you observe',
    'add_tree_location':
        'Mark the exact location of the tree by long pressing on map',
    'go_back': 'Go back',
    'cancel': 'Cancel',
    'saving_tree': 'Saving the tree. Please wait...',
    'location_required': 'Locations service is required',
    'tree_location': 'Tree location',
    'session_expired': 'Session expired. Please Log in again',
    'error': 'Error',
    'no_internet_connection': 'There is no internet connection.',
    'something_went_wrong': 'Something went wrong. Please try again.',
    'retry': 'Retry',
    'camera_denied':
        'Camera acces denied. Please got to device settings to change it',
    'authorization_failed': 'Authorization has failed',
    'ok': 'Ok',
    'personal_info': 'Personal information',
    'about_app': 'About Application',
    'send_feedback': 'Send Feedback',
    'rate_us': 'Rate us',
    'privacy_policy': 'Privacy Policy',
    'rules': 'Rules',
    'logout': 'Logout',
    'version': 'Version @current_version',
    'your_account': 'Your Account',
    'choose_school': 'Choose your school',
    'mail_body': 'Let us know what you think\n'
  };

  final Map<String, String> _plPL = <String, String>{
    'my_trees_title': 'Moje drzewa',
    'my_tree_title': 'Moje drzewo',
    'add_tree_title': 'Dodaj drzewo',
    'challenges_title': 'Wyzwania',
    'welcome_name': 'Cześć @name!',
    'you_dont_have_tree_yet': 'Nie masz jeszcze dodanego żadnego drzewa.',
    'add_your_first_tree':
        'Dodaj swoje pierwsze drzewo i pomóż nam poprawić stan zieleni Naszego miasta',
    'next': 'Dalej',
    'reset_uppercased': 'RESET',
    'retake': 'Powtórz',
    'ready': 'Gotowe',
    'no_photo_selected': 'Nie wybrano zdjęcia',
    'add_tree_photos_description_1': 'Wykonaj kolejno ',
    'add_tree_photos_description_2': 'zdjęcia drzewa, liścia ',
    'add_tree_photos_description_3': 'oraz opcjonalnie zdjęcie ',
    'add_tree_photos_description_4': 'kory drzewa',
    'add_tree_photos_description_optional_items': 'zdjęcia drzewa, liścia',
    'take_tree_photo_title': 'Wykonaj zdjęcie całego drzewa',
    'take_tree_photo_body':
        'Zdjęcie na którym widoczna będzie korona oraz pień drzewa w możliwie w jaknajszerszej perspektywie',
    'take_leaf_photo_title': 'Wykonaj zdjęcie liścia drzewa',
    'take_leaf_photo_body':
        'Zdjęcie, na którym widoczny będzie liść drzewa w przybliżeniu',
    'take_bark_photo_title': 'Wykonaj zdjęcie kory drzewa',
    'take_bark_photo_body':
        'Zdjęcie, na którym widoczna będzie kora drzewa w przybliżeniu',
    'log_in_using_account': 'Zaloguj się za pomocą konta:',
    'enter_the_tree_species': 'Podaj gatunek drzewa',
    'add_tree_description': 'Dodaj opis drzewa',
    'add_perimeter_of_the_tree': 'Dodaj obwód drzewa',
    'add_tree_state': 'Dodaj stan drzewa',
    'search': 'Szukaj',
    'select': 'Wybierz',
    'tree_description_title': 'Dodaj opis drzewa',
    'tree_description_explanation_1':
        'Wpisz poniżej opis drzewa. Może to być np. opis jego cech charakterystycznych odróżniających go od innych drzew tego samego gatunku.',
    'tree_description_explanation_2': 'Opis jest nieobowiązkowy,',
    'tree_description_explanation_3':
        'ale będzie nam miło jak podzielisz się swoimi spostrzeżeniami. Dzięki!',
    'tree_description_hint': 'Wpisz tutaj swój opis...',
    'save': 'Zapisz',
    'add_circumference_title': 'Dodaj obwód drzewa',
    'add_circumference_description_1':
        'Wykonaj pomiar obwodu drzewa. Pomiar najłatwiej wykonasz.',
    'add_circumference_description_2': 'standardową taśmą miarniczą.',
    'add_measurement': 'Dodaj pomiar',
    'add_tree_condition': 'Dodaj stan drzewa',
    'add_tree_condition_description':
        'Na podstawie obserwacji, jak oceniach stan drzewa?',
    'add_tree_condition_input_title': 'Czy jesteś w stanie opisać stan drzewa?',
    'add_tree_condition_observation_title': 'Co zaobserwowałeś',
    'add_tree_location':
        'Zaznacz lokalizację drzewa przytrzymując palec na mapie',
    'go_back': 'Wróć',
    'cancel': 'Anuluj',
    'saving_tree': 'Zapisywanie drzewa. Proszę czekać...',
    'location_required': 'Usługa lokalizacje jest wymagana',
    'tree_location': 'Lokalizacja drzewa',
    'session_expired': 'Sesja wygasła. Zaloguj się ponownie',
    'error': 'Wystąpił błąd',
    'no_internet_connection': 'Brak połączenia z internetem',
    'something_went_wrong': 'Coś poszło nie tak. Spróbuj ponownie.',
    'retry': 'Spróbuj ponownie',
    'camera_denied':
        'Brak dostępu do aparatu. Przejdź do ustawień aplikacji, aby to zmienić',
    'authorization_failed': 'Autoryzacja nie powiodła się',
    'ok': 'Ok',
    'personal_info': 'Informacje osobowe',
    'about_app': 'O Aplikacji',
    'send_feedback': 'Wyślij Feedback',
    'rate_us': 'Oceń nas',
    'privacy_policy': 'Polityka Prywatności',
    'rules': 'Regulamin',
    'logout': 'Wyloguj się',
    'version': 'Wersja @current_version',
    'your_account': 'Twoje Konto',
    'choose_school': 'Wybierz swoją szkołę',
    'mail_body': 'Daj nam znać co uważasz\n'
  };
}

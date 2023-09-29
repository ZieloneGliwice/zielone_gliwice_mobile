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
    'rules': "Competition's rules",
    'logout': 'Logout',
    'version': 'Version @current_version',
    'your_account': 'Your Account',
    'choose_school': 'Choose your school',
    'mail_subject': 'Zielone Gliwice feedback',
    'mail_body': 'Let us know what you think about Zielone Gliwice\n',
    'popup_title': 'Competition for schools',
    'popup_content':
        'Zielone Gliwice runs a competition: "Zagraj w zielone".\nThe school whose students add the most trees wins.',
    'popup_skip': 'Skip',
    'popup_choose_school': 'Choose school',
    'about_app_content': '''
The application allows you to monitor trees in the city by automatically and manually tagging them.
The tree map visualized in this way is intended to analyze urban policy regarding green areas and how trees affect the city and, above all, the health of its inhabitants.
In the first phase, trees must be entered manually, then the created system will learn to recognize specific tree species based on photos of leaves.
In the second phase, the system that automatically recognizes trees will be able to collect points and take part in the game by searching for virtual birds located in trees throughout the city.    ''',
    'privacy_policy_content': '''
All rights to the content of the Zielone Gliwice mobile application are reserved. You have the right to download and share all or part of the content of the Zielone Gliwice mobile application, provided that you do not violate the copyright of Media 3.0 Foundation. No part of the Application may be copied in whole or in part for commercial purposes, electronically transmitted or otherwise modified, linked or used without the prior consent of Media 3.0 Foundation.
Protecting the privacy of the Users of our Application is of great importance to us. Below we publish an explanation of what data we collect and our policies for processing and using it. We limit the use and collection of information about Service Users to the minimum required to provide the highest level of service.

§ 1 General Information

The purpose of this Application is to provide the User with solutions that allow the implementation of fully secure online services, while respecting the principles of confidentiality and not disclosing them to other entities, except on the basis of express authorization received from the User or under generally applicable laws.
Media 3.0 Foundation will process the User's personal information only for the purpose for which it was received. The User acknowledges that the Administrator of your personal data being processed is Media 3.0 Foundation with its registered office in Gliwice, ul. Siemińskiego 25/4, with KRS number: 0000483399 (hereinafter &quot;Administrator&quot;).
The Application User may be any natural person using the services provided through the Application on a mobile device.
The Administrator makes every effort to protect the privacy of Users on the Internet.
The Application can be installed on such mobile devices as a cell phone, after downloading the Application via:
in the case of an Android mobile device from Google Play
in the case of an iOS mobile device from the AppStore
The Administrator ensures that the use of the Application does not require any personal information that could in any way expose the User and thus allow a third party to identify a specific Application User.
The Application, depending on the platform, can only access data collected "automatically".
Automatically collected data include the Application ID on a given device automatically assigned by the Application backend and the push ID required for push communications. Both IDs are assigned automatically upon installation.
The automatic data is used to provide the basic functionality of the Application. Data collected automatically cannot be changed or deleted.
If you do not agree with this privacy policy, please do not install the Application or uninstall it.
Permanent deletion of the Application from your mobile device is equivalent to termination of your use of the Application.
This privacy policy is only supplementary to the privacy policies of Google Play and Appstore, and the Administrator does not assume any responsibility for the privacy policies of the above and for compliance with the provisions of the Data Protection Act and the Google Play and Appstore Electronic Services Act.

§ 2 Rights and obligations of the Administrator

The Administrator undertakes to process the User's personal data in accordance with the requirements of the Act of August 29, 1997 on the protection of personal data and the Act of July 18, 2002 on the provision of electronic services.
The Administrator guarantees to provide appropriate technical and organizational measures to ensure the security of the processed personal data, in particular to prevent access to them by unauthorized third parties or their processing in violation of generally applicable laws, to prevent loss of personal data, their damage or destruction.
The User's personal data will be stored for as long as it is necessary for the Administrator to perform the services provided through the Application.

§ 3 User Rights and Obligations

The User has the right to access his/her personal data through the Application.
The User may, at any time, modify, amend, supplement or delete the personal data provided through the tools available on the Application.
The Administrator reserves the right to make changes to the Privacy Policy, of which it will inform the User through the Application. If the User does not agree to the changes, he/she is obliged to permanently remove the Application from his/her mobile device.

§ 4 Information and rules of use of the Application

Use of the Application is only possible online, and therefore it is necessary for the User to have permanent access to the Internet.
The use of the Application processes the User&#39;s personal data in the form of name, surname, cell phone number, e-mail address, as well as the information provided by the User regarding the location and description of the tree he pins on the map.
Providing personal data is voluntary, but failure to do so may prevent feedback contact with the User.
When using the Application, the User is obliged to provide only his/her own personal data.
The User is responsible for any claims related to the violation of the rights of third parties when using the Application.
The location of the tree can be entered by:
- marking a point on the map; - entering an address from a specific field in the form; - using the geolocation button, provided that GPS is turned on and you are present at the location.
All collected data are processed exclusively in the Application. The acquired tree information is possible to be processed and analyzed by third parties.
The tree description does not contain personal data of Users.

§ 5 Contact
In matters concerning the manner and scope of processing of your data, as well as about your rights, please write to: kontakt@media30.pl.

§ 6 Changes

In the event of changes to the current privacy policy of the Zielone Gliwice mobile application, appropriate modifications will be made to the above provision.
    ''',
    'rules_content': '''
1. Organizator:

Konkurs "Zagraj w zielone"; jest organizowany przez Fundację Media 3.0 realizującą projekt “Zielone Gliwice 3.0”, finansowany z Funduszy EOG w ramach Programu Aktywni Obywatele - Fundusz Regionalny.

2. Czas trwania:

Konkurs rozpoczyna się 2.10.2023 r. w poniedziałek od godziny 00:00 i trwa do 22.10.2023 r. w niedzielę do godziny 00:00. Co tydzień (9.10, 16.10 i 22.10) będą podawane wyniki i szkoła, która aktualnie będzie zajmować pierwsze miejsce na podium otrzyma nagrodę za pierwsze miejsce.

3. Zasady uczestnictwa:

a) Konkurs skierowany jest do uczniów szkół podstawowych oraz szkół średnich miasta Gliwice.
b) Aby wziąć udział w konkursie, uczestnik musi ściągnąć aplikację "Zielone
Gliwice" z App Store (dla użytkowników iOS) lub z Google Play (dla użytkowników
Androida) i zalogować się.
c) Każdy użytkownik musi w aplikacji zaznaczyć swoją szkołę, aby jego piny były
liczone do konkursu.

4. Mechanika konkursu:

a) Uczestnik ma za zadanie &quot;pinować&quot; gliwickie drzewa na mapie w aplikacji.
b) Pinując drzewo, uczestnik zobowiązany jest do zrobienia zdjęcia drzewa zgodnie z wskazówkami zawartymi w aplikacji oraz podania kilku podstawowych informacji o nim.
c) Aby drzewo zostało uznane za zapinowane, uczestnik musi dostarczyć wymagane zdjęcia oraz podać minimum gatunek drzewa.
d) Pinowanie drzew może odbywać się w ramach klasowych spacerów edukacyjnych pod okiem nauczyciela/ki lub w czasie wolnym uczniów.

5. Nagrody:

a) Szkoły, które zapinują najwięcej drzew, otrzymają czujniki do monitorowania powietrza, tablety oraz specjalne koszulki i torby.
b) W trakcie trwania konkursu na emaila kontakt@media30.pl można przesyłać zdjęcia z pinowania drzew lub zajęć dotyczących ekologii. Nauczyciel (wraz z uczniami), który prześle najlepsze zdjęcia otrzyma specjalną nagrodę w postaci pendrivów i zestawu Arduino.

6. Ochrona danych:

Dane osobowe uczestników są przechowywane i przetwarzane zgodnie z politykami prywatności opisanymi w aplikacjach App Store i Google Play oraz zgodnie z obowiązującymi przepisami prawa.

7. Kontakt:

Wszelkich informacji udzielamy pod adresem: kontakt@media30.pl, w tytule: “konkurs”. Pełny regulamin dostępny jest pod adresem: https://t.ly/UZEa3

8. Postanowienia końcowe:

a) Wszelkie spory wynikające z uczestnictwa w konkursie będą rozstrzygane przez Organizatora. Decyzja Organizatora jest ostateczna.
b) Organizator zastrzega sobie prawo do wprowadzenia zmian w regulaminie w trakcie trwania konkursu.
c) Zaakceptowanie i uczestnictwo w konkursie oznacza akceptację powyższego regulaminu oraz regulaminu dostępnego pod adresem https://t.ly/UZEa3.
''',
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
    'rules': 'Regulamin konkursu',
    'logout': 'Wyloguj się',
    'version': 'Wersja @current_version',
    'your_account': 'Twoje Konto',
    'choose_school': 'Wybierz swoją szkołę',
    'mail_subject': 'Zielone Gliwice feedback',
    'mail_body': 'Daj nam znać co uważasz o Zielone Gliwice\n',
    'popup_title': 'Konkurs dla szkół',
    'popup_content':
        'Zielone Gliwice prowadzą konkurs "Zagraj w zielone".\nWygrywa szkoła, której uczniowie dodadzą najwięcej drzew.',
    'popup_skip': 'Pomiń',
    'popup_choose_school': 'Wybierz szkołę',
    'about_app_content': '''
Aplikacja umożliwia monitorowanie drzew w mieście poprzez ich automatyczne i ręczne tagowanie.
Zwizualizowana w ten sposób mapa drzew ma na celu analizę polityki miejskiej w zakresie terenów zielonych oraz jak drzewa wpływają na miasto i przede wszystkim zdrowie mieszkańców.
W pierwszej fazie drzewa należy wprowadzać ręcznie, następnie stworzony system nauczy się rozpoznawać konkretne gatunki drzew po zdjęciach liści.
W drugiej fazie do automatycznie rozpoznającego drzewa systemu wprowadzona zostanie możliwość zbierania punktów i wzięcia udziału w grze poprzez wyszukiwanie wirtualnych ptaków rozmieszczonych na drzewach na terenie całego miasta.
    ''',
    'privacy_policy_content': '''
Wszelkie prawa do zawartości aplikacji mobilnej Zielone Gliwice są zastrzeżone. Użytkownik ma prawo do pobierania oraz udostępniania całych treści lub fragmentów aplikacji mobilnej Zielone Gliwice pod warunkiem nienaruszania praw autorskich Fundacji Media 3.0. Żadna część Aplikacji nie może być w całości lub w części kopiowana w celach komercyjnych, transmitowana elektronicznie lub w inny sposób modyfikowana, linkowana lub wykorzystana bez uprzedniej zgody Fundacji Media 3.0.

Ochrona prywatności Użytkowników naszej Aplikacji ma dla nas bardzo duże znaczenie.
Poniżej publikujemy wyjaśnienie, jakie dane są przez nas gromadzone oraz jakie zasady ich przetwarzania i wykorzystywania są przez nas stosowane. Ograniczamy wykorzystanie i zbieranie informacji o Użytkownikach serwisu do niezbędnego minimum wymaganego do świadczenia usług na najwyższym poziomie.
 
§ 1 Informacje ogólne

1. Celem niniejszej Aplikacji jest dostarczenie Użytkownikowi rozwiązań, które pozwalają na realizację w pełni bezpiecznych usług online, z jednoczesnym poszanowaniem zasad poufności i nieujawniania ich innym podmiotom, chyba że na podstawie wyraźnego upoważnienia otrzymanego od Użytkownika lub na podstawie powszechnie obowiązujących przepisów prawa.
2. Fundacja Media 3.0 będzie przetwarzała dane osobowe Użytkownika tylko w celu w jakim je otrzymała. Użytkownik przyjmuje do wiadomości, że Administratorem Pani/Pana danych osobowych przetwarzanych jest Fundacja Media 3.0 z siedzibą w Gliwicach ul. Siemińskiego 25/4 o numerze KRS: 0000483399 (dalej „Administrator”).
3. Użytkownikiem Aplikacji może być każda osoba fizyczna korzystająca na urządzeniu mobilnym z usług świadczonych za pośrednictwem Aplikacji.
4. Administrator dokłada wszelkich starań, aby prywatność Użytkowników w Internecie była chroniona.
5. Aplikację można zainstalować na takich urządzeniach mobilnych, jak telefon komórkowy, po uprzednim pobraniu aplikacji za pośrednictwem:
a. w przypadku urządzenia mobilnego z systemem Android z Google Play
b. w przypadku urządzenia mobilnego z systemem iOS z AppStore
6. Administrator zapewnia, że korzystanie z Aplikacji nie wymaga podania jakichkolwiek danych osobowych, które w jakikolwiek sposób mogłyby narazić Użytkownika i tym samym umożliwić osobie trzeciej identyfikację konkretnego Użytkownika Aplikacji.
7. Aplikacja w zależności od platformy może uzyskać jedynie dostęp do danych zbieranych „automatycznie”. Do danych zbieranych automatycznie należą: identyfikator aplikacji na danym urządzeniu nadawany automatycznie przez backend Aplikacji oraz identyfikator push wymagany do komunikacji push. Oba identyfikatory są nadawane automatycznie po zainstalowaniu.
8. Dane automatyczne służą do zapewnienia podstawowych funkcjonalności Aplikacji. Danych zbieranych automatycznie nie ma możliwości zmiany bądź usunięcia.
9. W przypadku braku zgody na niniejszą politykę prywatności proszę nie instalować Aplikacji lub ją odinstalować. Trwałe usunięcie Aplikacji z urządzenia mobilnego jest równoznaczne z zakończeniem korzystania z Aplikacji.
10. Niniejsza polityka prywatności ma jedynie charakter uzupełniający w stosunku do polityki prywatności Google Play oraz Appstore, a Administrator nie ponosi jakiejkolwiek odpowiedzialności za politykę prywatności powyższych oraz za przestrzeganie przepisów ustawy o ochronie danych osobowych oraz ustawy o świadczeniu usług drogą elektroniczną w ramach Google Play oraz Appstore.

§ 2 Prawa i obowiązki Administratora

1. Administrator zobowiązuje się przetwarzać dane osobowe Użytkownika z zachowaniem wymogów Ustawy z dnia 29 sierpnia 1997 roku o ochronie danych osobowych oraz Ustawy z dnia 18 lipca 2002 roku o świadczeniu usług drogą elektroniczną.
2. Administrator gwarantuje zapewnienie odpowiednich środków technicznych i organizacyjnych zapewniających bezpieczeństwo przetwarzanych danych osobowych, w szczególności uniemożliwiających dostęp do nich nieuprawnionym osobom trzecim lub ich przetwarzania z naruszeniem przepisów powszechnie obowiązującego prawa, zapobiegających utracie danych osobowych, ich uszkodzeniu lub zniszczeniu.
3. Dane osobowe Użytkownika będą przechowywane tak długo, jak będzie to konieczne do realizacji przez Administratora usług świadczonych za pośrednictwem Aplikacji.

§ 3 Prawa i obowiązki Użytkownika

1. Użytkownik ma prawo dostępu do swoich danych osobowych za pośrednictwem Aplikacji.
2. Użytkownik może w każdej chwili dokonać modyfikacji, zmiany, uzupełnienia lub usunięcia udostępnionych danych osobowych za pośrednictwem narzędzi dostępnych w Aplikacji.
3. Administrator zastrzega sobie prawo wprowadzenia zmian w Polityce Prywatności, o czym poinformuje Użytkownika za pośrednictwem Aplikacji. Jeżeli Użytkownik nie wyrazi zgody na wprowadzone zmiany, zobowiązany jest trwale usunąć Aplikację ze swojego urządzenia mobilnego.

§ 4 Informacje i zasady korzystania z Aplikacji

1. Korzystanie z Aplikacji możliwe jest wyłącznie w trybie on-line, w związku z czym niezbędne jest posiadanie przez Użytkownika stałego dostępu do sieci Internet.
2. W ramach użytkowania Aplikacji przetwarzane są dane osobowe Użytkownika w postaci: imienia, nazwiska, numeru telefonu komórkowego, adresu e-mail, oraz przekazane przez Użytkownika informacje dotyczące miejsca i opisu drzewa, które pinuje na mapie.
3. Podanie danych osobowych jest dobrowolne, ale ich brak może uniemożliwić kontakt zwrotny z Użytkownikiem.
4. Korzystając z Aplikacji, Użytkownik jest zobowiązany do podania wyłącznie własnych danych osobowych.
5. Użytkownik ponosi odpowiedzialność za ewentualne roszczenia związane z naruszeniem podczas korzystania z Aplikacji praw osób trzecich.
6. Lokalizację drzewa można wprowadzić poprzez:
• zaznaczenie punktu na mapie;
• wprowadzenie adresu z określonego pola w formularzu;
• skorzystanie z przycisku geolokalizacji, pod warunkiem włączenia GPS i obecności w danym miejscu.
7. Wszystkie zgromadzone dane przetwarzane są wyłącznie w Aplikacji. Pozyskane informacje dotyczące drzew możliwe są do przetwarzania i analizowania przez strony trzecie.
8. Opis drzewa nie zawiera danych osobowych Użytkowników.

§ 5 Kontakt

W sprawach dotyczących sposobu i zakresu przetwarzania Pani/Pana danych, a także o przysługujące Pani/Panu prawa należy pisać na adres: kontakt@media30.pl.

§ 6 Zmiany

W przypadku zmiany obowiązującej polityki prywatności w aplikacji mobilnej Zielone Gliwice, wprowadzone zostaną odpowiednie modyfikacje do powyższego zapisu.
    ''',
    'rules_content': '''
1. Organizator:

Konkurs "Zagraj w zielone"; jest organizowany przez Fundację Media 3.0 realizującą projekt “Zielone Gliwice 3.0”, finansowany z Funduszy EOG w ramach Programu Aktywni Obywatele - Fundusz Regionalny.

2. Czas trwania:

Konkurs rozpoczyna się 2.10.2023 r. w poniedziałek od godziny 00:00 i trwa do 22.10.2023 r. w niedzielę do godziny 00:00. Co tydzień (9.10, 16.10 i 22.10) będą podawane wyniki i szkoła, która aktualnie będzie zajmować pierwsze miejsce na podium otrzyma nagrodę za pierwsze miejsce.

3. Zasady uczestnictwa:

a) Konkurs skierowany jest do uczniów szkół podstawowych oraz szkół średnich miasta Gliwice.
b) Aby wziąć udział w konkursie, uczestnik musi ściągnąć aplikację "Zielone
Gliwice" z App Store (dla użytkowników iOS) lub z Google Play (dla użytkowników
Androida) i zalogować się.
c) Każdy użytkownik musi w aplikacji zaznaczyć swoją szkołę, aby jego piny były
liczone do konkursu.

4. Mechanika konkursu:

a) Uczestnik ma za zadanie &quot;pinować&quot; gliwickie drzewa na mapie w aplikacji.
b) Pinując drzewo, uczestnik zobowiązany jest do zrobienia zdjęcia drzewa zgodnie z wskazówkami zawartymi w aplikacji oraz podania kilku podstawowych informacji o nim.
c) Aby drzewo zostało uznane za zapinowane, uczestnik musi dostarczyć wymagane zdjęcia oraz podać minimum gatunek drzewa.
d) Pinowanie drzew może odbywać się w ramach klasowych spacerów edukacyjnych pod okiem nauczyciela/ki lub w czasie wolnym uczniów.

5. Nagrody:

a) Szkoły, które zapinują najwięcej drzew, otrzymają czujniki do monitorowania powietrza, tablety oraz specjalne koszulki i torby.
b) W trakcie trwania konkursu na emaila kontakt@media30.pl można przesyłać zdjęcia z pinowania drzew lub zajęć dotyczących ekologii. Nauczyciel (wraz z uczniami), który prześle najlepsze zdjęcia otrzyma specjalną nagrodę w postaci pendrivów i zestawu Arduino.

6. Ochrona danych:

Dane osobowe uczestników są przechowywane i przetwarzane zgodnie z politykami prywatności opisanymi w aplikacjach App Store i Google Play oraz zgodnie z obowiązującymi przepisami prawa.

7. Kontakt:

Wszelkich informacji udzielamy pod adresem: kontakt@media30.pl, w tytule: “konkurs”. Pełny regulamin dostępny jest pod adresem: https://t.ly/UZEa3

8. Postanowienia końcowe:

a) Wszelkie spory wynikające z uczestnictwa w konkursie będą rozstrzygane przez Organizatora. Decyzja Organizatora jest ostateczna.
b) Organizator zastrzega sobie prawo do wprowadzenia zmian w regulaminie w trakcie trwania konkursu.
c) Zaakceptowanie i uczestnictwo w konkursie oznacza akceptację powyższego regulaminu oraz regulaminu dostępnego pod adresem https://t.ly/UZEa3.
''',
  };
}

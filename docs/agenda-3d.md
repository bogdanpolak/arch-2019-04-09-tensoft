# Dzień 1: Nowoczesne programowanie w Delphi

1. Zaawansowane programowanie obiektowe
	* [x] Klasy wspomagające (class helpers), metody anonimowe
	* [x] Wykorzystanie zdarzeń
	* [x] Enumeratory, polimorfizm, klasy abstrakcyjne i zastosowanie interfejsów
	* [x] Typy generyczne i kolekcje generyczne
1. Programowanie wielowątkowe
	* [x] Sekcje bezpieczne
	* [x] Wielowątkowe pobieranie i przetwarzanie danych na serwerze SQL 
1. Wymiana informacji między systemami
	* [x] Moduł System.JSON - przetwarzanie danych w formacie JSON
	* [x] Komponent TXMLDocument - przetwarzanie danych w formacie XML

# Dzień 2: Komunikacja sieciowa

1. Przegląd protokołów i standardów sieciowych
	* [x] Wprowadzenie do protokołu TCP/IP oraz HTTP
	* [x] Omówienie mechanizmów sieci WWW
	* [x] Specyfikacje HTML, MIME, SSL ,SOAP, REST
1. Komponenty Indy - komunikacja TCP
	* [x] Komponenty TIdTCPClient i TIdTCPServer
	* [x] Planowanie protokołu komunikacyjnego, przygotowanie wiadomości
	* [x] Wysyłanie i odbieranie wiadomości
	* [x] Tworzenie serwera jako usługi systemowej
1. Tworzenie serwerów HTTP w technologii WebBroker
	* [x] Zasady tworzenia i struktura serwera. 
	* [x] Przetwarzania parametrów. 
	* [x] Wysyłanie odpowiedzi tekstowej i binarnej.
	* [x] Typ wiadomości HTTP i definicje MIME - standardy kodowania wiadomości tekstowych i binarnych
	* [x] Przesyłanie danych relacyjnych z bazy SQL
	* [x] Obsługa poleceń HTTP: GET, POST, PUT, DELETE
	* [x] Instalacja i wdrażanie serwerów WebBroker.
1. Komponent TIdHTTP - klient HTTP
	* [ ] Pobieranie danych z sieci. 
	* [ ] Stworzenie serwera i obsługa żądań i analiza parametrów. 
	* [ ] Metody wywołań: GET, POST, PUT, DELETE. 
	* [ ] Przygotowanie nagłówka wiadomości HTTP 
	* [ ] Kontrola pobieranego strumienia. 
	* [ ] Wykorzystanie wzorca REST do przekazywania danych.
	* [ ] Komunikacja z serwerami WebServices - tworzenie koperty SOAP w XML-u oraz przetwarzanie odpowiedzi

# Dzień 3: FireDAC, komunikacja z Firebird 3

1. Budowa i konfiguracja wydajnych aplikacji SQL dla serwera Firebird
	* [x] Wykorzystanie definicji połączenia jako aliasu. Dynamiczne definiowanie połączeń. Użytkownik aplikacyjny i autentykacja użytkownika końcowego.
	* [x] System opcji FireDAC: optymalizacja fetch-owania wierszy, konfiguracja algorytmu automatycznej generacji poleceń UPDATE i INSERT, stronicowanie wierszy, opóźnione pobieranie pól BLOB
1. Bezpieczeństwo aplikacji
	* [x] Zarządzanie połączeniem z serwerem. Odzyskiwanie połączeń utraconych, przełączanie połączenia w tryb off-line. Diagnostyka.
	* [x] Automatyczne zarządzanie transakcjami przez FireDAC-a a system transakcji serwera Firebird. Transakcje zagnieżdżone i transakcje ciągłe.
1. Przegląd tematów zaawansowanych
	* [x] Wykorzystanie Array DML - błyskawiczne dodawanie i modyfikacja dużych ilości danych do tabel
	* [x] Silnik local SQL - integracja danych z różnych źródeł
	* [x] Obsługa pól auto-numerowanych i sekwencji / generatorów.

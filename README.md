# CookBook - Osobisty Organizator Przepisów

## 1. Opis aplikacji
**CookBook** to natywna aplikacja mobilna na system iOS, służąca do gromadzenia, przechowywania i przeglądania przepisów kulinarnych. Projekt powstał jako odpowiedź na potrzebę posiadania prostego, estetycznego narzędzia do cyfrowego zapisywania pomysłów na dania, eliminującego konieczność korzystania z papierowych notatników.

**Grupa docelowa:** Osoby gotujące w domu, pasjonaci eksperymentów w kuchni oraz kolekcjonerzy przepisów

## 2. Wybrana technologia
Projekt zrealizowano w technologii natywnej **Apple iOS**.

* **Język:** Swift 5.9
* **Interfejs:** SwiftUI
* **Baza danych:** SwiftData
* **Środowisko:** Xcode 15+

**Uzasadnienie wyboru:**
Wybrałem technologię natywną ze względu na najlepszą wydajność i dostęp do komponentów (kamera, galeria) oraz intuicyjny framework SwiftUI.
Było to też najprostsze rozwiązanie z racji pracy na macu.

## 3. Architektura aplikacji
Aplikacja oparta jest o architekturę deklaratywną zgodną ze wzorcem **MVVM** (Model-View-ViewModel), wpieraną natywnie przez SwiftUI.

* **Model:** Struktura danych `Recipe` (Tytuł, Składniki, Instrukcje, Zdjęcie).
* **Widok (View):** Warstwa prezentacji (`ContentView`, `AddRecipeView`, `RecipeDetailView`).
* **Dane:** Kontener `SwiftData` zarządzający zapisem i odczytem (CRUD).

## 4. Zaimplementowane funkcjonalności
Aplikacja spełnia 5 kluczowych wymagań projektowych:

1.  **Wiele ekranów i nawigacja:**
    * Ekran główny (Lista przepisów).
    * Ekran szczegółów (Pełny widok przepisu).
    * Ekran dodawania (Formularz).
    * Nawigacja realizowana przez `NavigationStack`.

2.  **Przechowywanie danych (Persistence):**
    * Wykorzystanie **SwiftData** do trwałego zapisu przepisów w pamięci urządzenia. Dane nie znikają po zamknięciu aplikacji.

3.  **Multimedia (Kamera i Galeria):**
    * Integracja z `UIKit` poprzez `UIViewControllerRepresentable` w celu obsługi aparatu.
    * Możliwość wykonania zdjęcia potrawy lub wybrania go z biblioteki zdjęć.

4.  **Lista elementów:**
    * Wyświetlanie dynamicznej listy przepisów z miniaturkami zdjęć.
    * Obsługa gestów (Swipe-to-delete) do usuwania elementów.

5.  **Interakcja z użytkownikiem:**
    * Formularze z walidacją (blokada przycisku "Zapisz" przy pustym tytule).
    * Obsługa stanów pustych (Empty State) zachęcająca do dodania pierwszego wpisu.


## 6. Instrukcja uruchomienia
Aby uruchomić projekt na własnym komputerze:

1.  Wymagany system macOS oraz zainstalowane środowisko **Xcode** (wersja 15 lub nowsza).
2.  Sklonuj repozytorium lub pobierz pliki ZIP.
3.  Otwórz plik `CookBook.xcodeproj`.
4.  Poczekaj na pobranie indeksów i zbudowanie projektu.
5.  Wybierz symulator (np. iPhone 15/16) i wciśnij przycisk **Run** (Cmd + R).

## 7. Napotkane problemy i rozwiązania
* **Problem:** Integracja SwiftData ze starszymi wersjami iOS.
    * *Rozwiązanie:* Ograniczenie projektu do iOS 17.0+, co pozwoliło na użycie najnowszego, uproszczonego API bazy danych.
* **Problem:** Obsługa kamery w SwiftUI.
    * *Rozwiązanie:* Stworzenie mostu (`Coordinator`) pomiędzy nowym SwiftUI a starszym frameworkiem UIKit obsługującym `UIImagePickerController`.

## 8. Możliwości rozwoju
W przyszłości aplikacja może zostać rozbudowana o:
* Wyszukiwanie i filtrowanie przepisów po składnikach.
* Kategorie przepisów (Śniadania, Obiady).
* Możliwość udostępniania przepisu znajomym.


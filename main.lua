--jak się zostawi otwartą aplikację i potem ruszy to całkiem wariuje - jakby wszystkie obliczenia szły dalej a nie startowały od zera
--problem polega też i na tym, że nie tworzę każdy level osobno, więc nie mogę ich stworzyć nieskończenie wiele
--najlepiej by było zdefiniować funkcje w jednym pliku i potem już tylko wywoływać je w levelach
-- kidy jest więcej niż jedna linia - jeszcze źle zarządzam zbieraniem punktów i czyszczeniem planszy kiedy kończy się level
--powinnam prowadzić ogólny rejestr punktów w całej grze a nie tylko w pojedyńczych levelach
--powinno być jakieś fajne przejście między levelami - coś co by cie informowało czy wygrywasz czy przegrywasz
-- powinno być jakieś zarządzanie czasem - może nie musi przyspieszać aż tak bardzo ale może niech to tempo będzie odczuwalne,
-- decyzja czy 10 punktów do zdobycia na planszę to jest dobra liczba
-- znaleźć odpowiednie kolory/ szatę graficzną dla tej gry 

display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

composer.gotoScene( "menu", "fade", 400 )
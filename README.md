# Furniture Manufacturing Database

**MS SQL Server database project for a furniture manufacturing and sales company, including production planning, order handling, warehouse tracking, reporting, and business logic.**

## Overview

Furniture Manufacturing Database is a database system designed for a production and service company that manufactures and sells furniture used in computer-equipped spaces such as classrooms, offices, and gaming rooms.

The project was implemented using **MS SQL Server** and focuses on modeling the company’s production, warehouse, sales, and reporting processes. The system supports both individual and business customers, tracks product inventory, stores historical orders, estimates production time and cost, and provides analytical tools for business management.

The main goal of the project was to design a complete relational database schema together with key database mechanisms such as views, stored procedures, triggers, functions, indexes, and role-based permissions.

## Main Business Scope

The system covers:
- furniture production,
- warehouse management,
- order processing,
- customer and discount handling,
- production planning,
- reporting and analytics.

The company produces products such as:
- chairs,
- desks,
- gaming desks,
- tables,
- office chairs,
- gaming chairs,
- mobile stands for projectors,
- stands for interactive boards.

Each product is composed of specific parts and quantities. The database stores product definitions, required materials, estimated production cost, and estimated production time.

## Features

- relational database schema for a manufacturing and sales company
- product structure based on component definitions
- warehouse stock tracking for finished products
- production planning for products unavailable in stock
- support for online sales
- customer order history
- discount assignment for individual orders
- analytical reports for sales, production, and warehouse state
- stored procedures, functions, triggers, and views
- indexes for improving query performance
- role-based access control

## Database Scope

The project includes:
- database schema design
- implementation in MS SQL Server
- integrity constraints
- generated test data
- views simplifying data access
- stored procedures implementing key system operations
- triggers supporting business rules
- functions for reusable logic
- indexes for performance optimization
- roles and permissions for selected user groups

## Example Functional Areas

### Production

The database allows:
- storing product definitions and bill of materials,
- defining what parts are needed to produce each product,
- estimating production cost,
- estimating production time,
- planning production depending on available resources and capacity.

### Warehouse

The system tracks:
- current stock of finished products,
- products already manufactured,
- products planned for production,
- stock reductions caused by customer orders.

### Sales

The database supports:
- online sales for individual and business customers,
- order history,
- payment handling,
- discounts assigned to orders,
- checking whether missing products can be produced within the customer’s requested time.

### Analytics

The system supports reports related to:
- production costs by product and product group,
- warehouse state,
- previous customer orders and discounts,
- weekly and monthly sales,
- weekly and monthly production costs,
- production plans in different time ranges.

## Technologies

- MS SQL Server
- T-SQL
- Relational database design
- Views
- Stored Procedures
- Functions
- Triggers
- Indexes
- Role-based permissions

## Project Structure

Example repository structure:

- `schema/` — table definitions and constraints
- `data/` — generated sample data
- `views/` — SQL views
- `procedures/` — stored procedures
- `functions/` — database functions
- `triggers/` — triggers
- `indexes/` — index definitions
- `roles/` — roles and permissions
- `reports/` — analytical queries and reports
- `docs/` — documentation and diagrams

## My Contribution

This repository is my portfolio copy of an academic database project.

My work included:
- designing the relational database schema,
- defining entities and relationships,
- implementing integrity constraints,
- creating SQL views,
- writing stored procedures, triggers, and functions,
- generating sample data,
- preparing reporting queries,
- designing indexes and permission structure.

## How to Run

1. Open **MS SQL Server Management Studio** or another compatible SQL client.
2. Create a new database.
3. Run the SQL scripts in the proper order, for example:
   - schema
   - constraints
   - sample data
   - views
   - functions
   - procedures
   - triggers
   - indexes
   - roles
4. Execute reporting queries or test selected procedures.

## Why this project is valuable

This project demonstrates:
- practical relational database design,
- business process modeling,
- implementation of database logic in T-SQL,
- use of views, procedures, functions, and triggers,
- performance optimization with indexes,
- access management using roles and permissions,
- translation of business requirements into a working database system.

## Notes

This project was created as part of an academic database course.  
The repository is intended for educational and portfolio presentation.

---

# Polski

**Projekt bazy danych w MS SQL Server dla firmy zajmującej się produkcją i sprzedażą mebli, obejmujący planowanie produkcji, obsługę zamówień, kontrolę stanów magazynowych, raportowanie oraz logikę biznesową.**

## Opis projektu

Furniture Manufacturing Database to system bazodanowy zaprojektowany dla firmy produkcyjno-usługowej zajmującej się produkcją i sprzedażą mebli wykorzystywanych w pomieszczeniach wyposażonych w sprzęt komputerowy, takich jak sale dydaktyczne, biura czy pokoje gamingowe.

Projekt został zrealizowany z użyciem **MS SQL Server** i koncentruje się na modelowaniu procesów produkcyjnych, magazynowych, sprzedażowych oraz raportowych. System obsługuje zarówno klientów indywidualnych, jak i firmy, śledzi stany magazynowe produktów, przechowuje historię zamówień, pozwala szacować czas i koszt produkcji oraz dostarcza narzędzia analityczne dla zarządzania.

Głównym celem projektu było zaprojektowanie kompletnego schematu relacyjnej bazy danych wraz z kluczowymi mechanizmami bazodanowymi, takimi jak widoki, procedury składowane, triggery, funkcje, indeksy oraz role i uprawnienia.

## Główny zakres biznesowy

System obejmuje:
- produkcję mebli,
- zarządzanie magazynem,
- obsługę zamówień,
- obsługę klientów i rabatów,
- planowanie produkcji,
- raportowanie i analitykę.

Firma produkuje między innymi:
- krzesła,
- biurka,
- biurka gamingowe,
- stoły,
- fotele biurowe,
- fotele gamingowe,
- ruchome stojaki na projektory,
- stojaki pod tablice interaktywne.

Każdy produkt składa się z określonych części i ilości. Baza danych przechowuje definicje produktów, wymagane materiały, szacowany koszt produkcji oraz szacowany czas wykonania.

## Funkcjonalności

- relacyjny schemat bazy danych dla firmy produkcyjno-sprzedażowej
- modelowanie struktury produktów na podstawie definicji części
- śledzenie stanów magazynowych gotowych produktów
- planowanie produkcji dla produktów niedostępnych w magazynie
- obsługa sprzedaży internetowej
- historia zamówień klientów
- możliwość przypisywania rabatów do zamówień
- raporty analityczne dotyczące sprzedaży, produkcji i magazynu
- procedury składowane, funkcje, triggery i widoki
- indeksy poprawiające wydajność zapytań
- kontrola dostępu oparta na rolach

## Zakres bazy danych

Projekt obejmuje:
- zaprojektowanie schematu bazy danych
- implementację w MS SQL Server
- warunki integralności
- wygenerowane dane testowe
- widoki ułatwiające dostęp do danych
- procedury składowane realizujące kluczowe operacje systemu
- triggery wspierające reguły biznesowe
- funkcje realizujące wielokrotnie używaną logikę
- indeksy poprawiające wydajność
- role i uprawnienia dla wybranych grup użytkowników

## Przykładowe obszary funkcjonalne

### Produkcja

Baza danych umożliwia:
- przechowywanie definicji produktów i list materiałowych,
- określenie, jakie części są potrzebne do wykonania każdego produktu,
- szacowanie kosztu produkcji,
- szacowanie czasu produkcji,
- planowanie produkcji w zależności od zasobów i mocy przerobowych.

### Magazyn

System śledzi:
- bieżące stany gotowych produktów,
- produkty już wyprodukowane,
- produkty zaplanowane do produkcji,
- zmniejszanie stanów magazynowych w wyniku zamówień klientów.

### Sprzedaż

Baza danych wspiera:
- sprzedaż internetową dla klientów indywidualnych i firm,
- historię zamówień,
- obsługę płatności,
- rabaty przypisywane do zamówień,
- sprawdzanie, czy brakujące produkty mogą zostać wyprodukowane w czasie wymaganym przez klienta.

### Analityka

System wspiera raporty dotyczące:
- kosztów produkcji według produktów i grup produktów,
- stanów magazynowych,
- wcześniejszych zamówień klientów i rabatów,
- sprzedaży tygodniowej i miesięcznej,
- tygodniowych i miesięcznych kosztów produkcji,
- planów produkcyjnych w różnych przedziałach czasu.

## Technologie

- MS SQL Server
- T-SQL
- projektowanie relacyjnych baz danych
- widoki
- procedury składowane
- funkcje
- triggery
- indeksy
- role i uprawnienia

## Struktura projektu

Przykładowa struktura repozytorium:

- `schema/` — definicje tabel i ograniczeń
- `data/` — wygenerowane dane przykładowe
- `views/` — widoki SQL
- `procedures/` — procedury składowane
- `functions/` — funkcje bazodanowe
- `triggers/` — triggery
- `indexes/` — definicje indeksów
- `roles/` — role i uprawnienia
- `reports/` — zapytania analityczne i raporty
- `docs/` — dokumentacja i diagramy

## Mój wkład

To repozytorium stanowi moją wersję portfolio projektu akademickiego z baz danych.

Moja praca obejmowała:
- zaprojektowanie relacyjnego schematu bazy danych,
- zdefiniowanie encji i relacji,
- implementację warunków integralności,
- tworzenie widoków SQL,
- napisanie procedur składowanych, triggerów i funkcji,
- wygenerowanie przykładowych danych,
- przygotowanie zapytań raportowych,
- zaprojektowanie indeksów oraz struktury uprawnień.

## Jak uruchomić

1. Otwórz **MS SQL Server Management Studio** lub inne kompatybilne narzędzie SQL.
2. Utwórz nową bazę danych.
3. Uruchom skrypty SQL w odpowiedniej kolejności, na przykład:
   - schema
   - constraints
   - sample data
   - views
   - functions
   - procedures
   - triggers
   - indexes
   - roles
4. Uruchom zapytania raportowe lub przetestuj wybrane procedury.

## Dlaczego ten projekt jest wartościowy

Projekt pokazuje w praktyce:
- projektowanie relacyjnych baz danych,
- modelowanie procesów biznesowych,
- implementację logiki bazodanowej w T-SQL,
- wykorzystanie widoków, procedur, funkcji i triggerów,
- optymalizację wydajności z użyciem indeksów,
- zarządzanie dostępem za pomocą ról i uprawnień,
- przełożenie wymagań biznesowych na działający system bazodanowy.

## Uwagi

Projekt został wykonany w ramach akademickiego kursu baz danych.  
Repozytorium zostało przygotowane w celach edukacyjnych i portfolio.

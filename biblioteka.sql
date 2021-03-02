-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 27 Lut 2021, 16:52
-- Wersja serwera: 10.4.14-MariaDB
-- Wersja PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `biblioteka`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `booked`
--

CREATE TABLE `booked` (
  `ID_booked` int(11) NOT NULL,
  `ID_book` int(11) NOT NULL,
  `book_name` varchar(50) NOT NULL,
  `ID_user` int(11) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `is_borrow` varchar(4) NOT NULL DEFAULT 'NIE',
  `is_borrow_back` varchar(4) NOT NULL DEFAULT 'NIE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `booked`
--

INSERT INTO `booked` (`ID_booked`, `ID_book`, `book_name`, `ID_user`, `first_name`, `last_name`, `email`, `is_borrow`, `is_borrow_back`) VALUES
(3, 23, '55342', 25, 'fgdh', 'fgdhg', 'dd@dd', 'TAK', 'TAK'),
(4, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(5, 2, 'Buszujący w zbożu', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(6, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(7, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(8, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(9, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(10, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(11, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(12, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(13, 1, 'Władca pierścieni', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(14, 2, 'Buszujący w zbożu', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(15, 2, 'Buszujący w zbożu', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(16, 2, 'Buszujący w zbożu', 25, 'Piotr', 'CIeślik', 'dd@dd', 'TAK', 'TAK'),
(20, 2, 'Buszujący w zbożu', 35, 'Piotr', 'Cieslik', 'pc@example.com', 'TAK', 'TAK'),
(21, 4, 'Paragraf 22', 35, 'Piotr', 'Cieslik', 'pc@example.com', 'TAK', 'TAK'),
(22, 1, 'Władca pierścieni', 43, 'Kacper', 'Furman', 'kacper@exampl.com', 'TAK', 'TAK'),
(23, 6, 'Alicja w krainie czarów', 44, 'Justyna', 'Klich', 'justyna@example.com', 'TAK', 'TAK'),
(24, 6, 'Alicja w krainie czarów', 46, 'Filip', 'Filipiak', 'filip@example.com', 'TAK', 'TAK'),
(25, 6, 'Alicja w krainie czarów', 47, 'Piotr', 'Cieślik', 'piotr@example.com', 'TAK', 'TAK'),
(27, 2, 'Buszujący w zbożu', 47, 'Piotr', 'Cieślik', 'piotr@example.com', 'NIE', 'NIE');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `books`
--

CREATE TABLE `books` (
  `ID_book` int(11) NOT NULL,
  `book_name` varchar(100) NOT NULL,
  `book_author_first_name` varchar(40) NOT NULL,
  `book_author_last_name` varchar(40) NOT NULL,
  `book_category` varchar(40) NOT NULL,
  `book_publication_year` varchar(40) NOT NULL,
  `books_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `books`
--

INSERT INTO `books` (`ID_book`, `book_name`, `book_author_first_name`, `book_author_last_name`, `book_category`, `book_publication_year`, `books_quantity`) VALUES
(1, 'Władca pierścieni', 'Marek', 'Tolkien', 'Fantasy', '1954-07-29', 5),
(2, 'Buszujący w zbożu', 'Jerome David', 'Salinger', 'Powieść młodzieżowa', '1951-07-16', 2),
(3, 'Duma i uprzedzenie', 'Jane', 'Austen', 'Romans', '1813-01-28', 2),
(4, 'Paragraf 22', 'Joseph', 'Heller', 'Powieść wojenna', '1975-07-01', 2),
(5, 'Wielki Gatsby', 'Francis Scott', 'Fitzgerald', 'Powieść', '1925-04-10', 5),
(6, 'Alicja w krainie czarów', 'Lewis', 'Carroll', 'Powieść', '1910-07-01', 1),
(7, 'Anna Karenina', 'Lew', 'Tołstoj', 'Powieść', '1877-07-01', 3),
(8, 'Sto lat samotności', 'Gabriel Garcia', 'Marquez', 'Powieść', '1974-07-01', 4),
(9, 'Zabić drozda', 'Lee', 'Harper', 'Dreszczowiec', '1960-11-11', 2),
(10, 'Rok 1984', 'George', 'Orwell', 'Fantastyka', '1949-06-08', 1),
(11, 'Grona gniewu', 'John', 'Steinbeck', 'Powieść', '1939-04-14', 4),
(12, 'Folwark zwierzęcy', 'George', 'Orwell', 'Powieść', '1945-08-17', 3),
(13, 'Wichrowe wzgórza', 'Emily', 'Bronte', 'Romans', '1929-07-01', 2),
(14, 'Autostopem przez galaktykę', 'Douglas', 'Adams', 'Powieść', '1979-10-12', 4),
(15, 'Opowieści z Narnii', 'C.S.', 'Lewis', 'Fantastyka', '1956-07-01', 4),
(16, 'Małe kobietki', 'Louisa May', 'Alcott', 'Powieść', '1868-09-30', 2),
(17, 'Pajęczyna Szarloty\r\n', 'E.B.', 'White', 'Powieść', '1952-10-15', 4),
(18, 'Władca much', 'William', 'Golding', 'Powieść', '1954-09-17', 4),
(19, 'Tajemniczy ogród', 'Frances Hodgson', 'Burnett', 'Literatura Dziecięca', '1911-07-01', 1),
(20, 'Mały Książę', 'Antoine', 'de Saint-Exupery', 'Literatura dziecięca', '1947-07-01', 1),
(21, 'Myszy i ludzie', 'John', 'Steinbeck', 'Nowela', '1937-11-23', 3),
(22, 'Miłość w czasach zarazy', 'Gabriel Garcia', 'Marquez', 'Romans', '1985-07-01', 5),
(23, 'Opowieść podręcznej', 'Margaret', 'Atwood', 'Fantastyka', '1985-07-01', 2),
(24, 'Rzeźnia numer pięć', 'Kurt', 'Vonnegut', 'Powieść', '1969-03-31', 5),
(25, 'Życie Pi', 'Yann', 'Martel', 'Powieść', '2001-09-11', 2),
(26, 'Pani Bovary', 'Gustave', 'Flaubert', 'Powieść', '1857-07-01', 1),
(27, 'Hamlet', 'William', 'Shakespeare', 'Dramat', '1599-07-01', 6),
(28, 'Kolor purpury', 'Alice', 'Walker', 'Powieść', '1982-07-01', 4),
(29, 'Opowieść wigilijna', 'Charles', 'Dickens', 'Nowela', '1843-12-19', 4),
(30, 'Ania z Zielonego Wzgórza', 'Lucy Maud', 'Montgomery', 'Powieść', '1908-07-01', 2),
(31, 'Wyznania Gejszy', 'Arthur', 'Golden', 'Powieść', '1997-09-27', 2),
(32, 'Drakula', 'Bram', 'Stoker', 'Horror', '1897-05-26', 2),
(33, 'Nowy wspaniały świat', 'Aldous Huxley', 'Huxley', 'Powieść', '1932-07-01', 3),
(34, 'Zbrodnia i kara', 'Fiodor', 'Dostojewski', 'Powieść', '1866-07-01', 2),
(35, 'Charlie i fabryka czekolady', 'Roald', 'Dahl', 'Baśń', '1964-01-17', 5),
(36, 'Modlitwa za Owena', 'John', 'Irving', 'Powieść', '1989-03-01', 2),
(37, 'Przygody Sherlocka Holmesa', 'Arthur Conan', 'Doyle', 'Powieść', '1892-10-14', 6),
(38, 'Mistrz i Małgorzata', 'Michaił', 'Bułhakow', 'Romans', '1969-07-01', 4),
(39, 'Lalka', 'Bolesław', 'Prus', 'Powieść', '1890-07-01', 9),
(40, 'Pokój pełen liści', 'Joan', 'Aiken', 'Fantastyka', '1969-07-01', 1),
(41, '451 stopni Fahrenheita', 'Ray', 'Bradbury', 'Powieść', '1953-10-19', 8),
(42, 'Romeo i Julia', 'William', 'Shakespeare', 'Tragedia', '1597-07-01', 5),
(43, 'Zły', 'Leopold', 'Tyrmand', 'Fikcja', '1956-07-01', 4),
(44, 'Przeminęło z wiatrem', 'Margaret', 'Mitchell', 'Powieść', '1936-06-30', 8),
(45, 'Lot nad kukułczym gniazdem', 'Ken', 'Kesey', 'Powieść', '1962-02-01', 2),
(46, 'Kompleks Portnoya', 'Phillip', 'Roth', 'Powieść', '1969-01-12', 4),
(47, 'Kod Leonarda da Vinci', 'Dan', 'Brown', 'Powieść', '2003-03-18', 3),
(48, 'Na wschód od Edenu', 'John', 'Steinbeck', 'Romans', '1952-09-19', 4),
(49, 'Igrzyska śmierci', 'Suzanne', 'Collins', 'Powieść', '2008-09-14', 3),
(50, 'Trans-Atlantyk', 'Witold', 'Gombrowicz', 'Powieść', '1953-07-01', 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `borrowed_books`
--

CREATE TABLE `borrowed_books` (
  `ID_borrow` int(11) NOT NULL,
  `ID_book` int(11) NOT NULL,
  `book_name` varchar(100) NOT NULL,
  `ID_user` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_booked` varchar(4) NOT NULL DEFAULT 'TAK',
  `is_borrow_back` varchar(4) NOT NULL DEFAULT 'NIE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `borrowed_books`
--

INSERT INTO `borrowed_books` (`ID_borrow`, `ID_book`, `book_name`, `ID_user`, `first_name`, `last_name`, `email`, `is_booked`, `is_borrow_back`) VALUES
(1, 7, 'Anna Karenina', 25, 'Piotr', 'Cieślik', 'dd@dd', 'TAK', 'TAK');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `data`
--

CREATE TABLE `data` (
  `ID_book` int(11) NOT NULL,
  `book_name` varchar(100) DEFAULT NULL,
  `book_author_first_name` varchar(40) DEFAULT NULL,
  `book_author_last_name` varchar(40) DEFAULT NULL,
  `book_category` varchar(40) DEFAULT NULL,
  `book_publication_year` varchar(40) DEFAULT NULL,
  `books_quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `ID_user` int(11) NOT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `user_phone_number` int(10) DEFAULT NULL,
  `password` varchar(30) NOT NULL DEFAULT 'cGFzcw==',
  `user_address_street` varchar(60) DEFAULT NULL,
  `user_address_city` varchar(40) DEFAULT NULL,
  `user_PESEL` int(11) DEFAULT NULL,
  `is_approved` varchar(4) NOT NULL DEFAULT 'NIE',
  `is_admin` varchar(4) NOT NULL DEFAULT 'NIE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`ID_user`, `first_name`, `last_name`, `email`, `user_phone_number`, `password`, `user_address_street`, `user_address_city`, `user_PESEL`, `is_approved`, `is_admin`) VALUES
(40, 'Jan', 'Nowak', 'jan@gmail.com', 345678984, 'MnN0ZXJlbzI=', 'Piłsudzkiego', 'Wrocław', 2147483647, 'TAK', 'NIE'),
(41, 'admin', NULL, 'admin@example.com', 123456789, 'cGFzc3dvcmQ=', 'Legnicka', 'Wrocław', 569867548, 'TAK', 'TAK'),
(44, 'Justyna', 'Klich', 'justyna@example.com', 345678987, 'aG9yeXpvbnQ=', 'Piłsudzkiego', 'Wrocław', 2147483647, 'TAK', 'NIE'),
(47, 'Piotr', 'Cieślik', 'piotr@example.com', 456543456, 'dGVzdG93ZQ==', 'legnicka', 'wroclaw', 2147483647, 'TAK', 'NIE');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `booked`
--
ALTER TABLE `booked`
  ADD PRIMARY KEY (`ID_booked`);

--
-- Indeksy dla tabeli `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`ID_book`);

--
-- Indeksy dla tabeli `borrowed_books`
--
ALTER TABLE `borrowed_books`
  ADD PRIMARY KEY (`ID_borrow`);

--
-- Indeksy dla tabeli `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`ID_book`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID_user`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `booked`
--
ALTER TABLE `booked`
  MODIFY `ID_booked` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT dla tabeli `books`
--
ALTER TABLE `books`
  MODIFY `ID_book` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT dla tabeli `borrowed_books`
--
ALTER TABLE `borrowed_books`
  MODIFY `ID_borrow` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `data`
--
ALTER TABLE `data`
  MODIFY `ID_book` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `ID_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

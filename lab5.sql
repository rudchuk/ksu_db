CREATE TABLE IF NOT EXISTS publishers (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS authors (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS categories (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS books (
    id INT(11) NOT NULL AUTO_INCREMENT,
    code INT(11) NOT NULL,
    is_new BOOLEAN DEFAULT false,
    name VARCHAR(255) NOT NULL,
    price FLOAT DEFAULT NULL,
    publisher_id INT(11) NOT NULL,
    pages INT(11) NOT NULL,
    format VARCHAR(50) DEFAULT NULL,
    published_at DATE DEFAULT NULL,
    circulation INT(11) NOT NULL,
    topic VARCHAR(255) NOT NULL,
    category_id INT(11) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS book_authors (
    book_id INT(11) NOT NULL,
    author_id INT(11) NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- Завантаження даних у таблиці

INSERT INTO publishers (id, name) VALUES
(1, 'Видавнича група BHV'),
(2, 'Вiльямс'),
(3, 'МикроАрт'),
(4, 'DiaSoft'),
(5, 'ДМК'),
(6, 'Триумф'),
(7, 'Эком'),
(8, 'Києво-Могилянська академія'),
(9, 'Університет Україна'),
(10, 'Вінниця: ВДТУ');

INSERT INTO authors (id, name) VALUES
(1, 'John Smith'),
(2, 'Jane Doe');

INSERT INTO categories (id, name) VALUES
(1, 'Підручники'),
(2, 'Апаратні засоби ПК'),
(3, 'Захист і безпека ПК'),
(4, 'Інші книги'),
(5, 'Операційні системи'),
(6, 'Програмування'),
(7, 'C&C++'),
(8, 'SQL');

INSERT INTO books (id, code, is_new, name, price, publisher_id, pages, format, published_at, circulation, topic, category_id) VALUES
(1, 5110, false, 'Апаратні засоби мультимедіа.Відеосистема PC', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 1),
(2, 4985, false, 'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид', 18.9, 2, 288, '70х100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 1),
(3, 5141, false, 'Структури даних та алгоритми', 37.8, 2, 384, '70х100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 1),
(4, 5127, false, 'Автоматизація інженерно-графічних робіт', 11.58, 1, 256, '70х100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 1),
(5, 5113, false, 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 2),
(6, 5199, false, 'Залізо IBM 2001 ', 30.07, 3, 368, '70х100/16', '2000-02-12', 5000, 'Використання ПК в цілому', 2),
(7, 3851, false, 'Захист інформації та безпека компютерних систем', 26, 4, 480, '84х108/16', '1900-01-01', 5000, 'Використання ПК в цілому', 3),
(8, 3932, false, 'Як перетворити персональний компютер на вимірювальний комплексс', 7.65, 5, 144, '60х88/16', '2000-06-09', 5000, 'Використання ПК в цілому', 4),
(9, 4713, false, 'Plug-ins. Додаткові програми для музичних програм', 11.41, 5, 144, '70х100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 4),
(10, 5217, false, 'Windows МЕ. Найновіші версії програм', 16.57, 6, 320, '70х100/16', '2000-08-25', 5000, 'Операційні системи', 5),
(11, 4829, false, 'Windows 2000 Professional крок за кроком з CD', 27.25, 7, 320, '70х100/16', '2000-04-28', 5000, 'Операційні системи', 5),
(12, 5170, false, 'Linux версії', 24.43, 5, 346, '70х100/16', '2000-09-29', 5000, 'Операційні системи', 5),
(13, 860, false, 'Операційна система UNIX', 3.5, 1, 395, '84х10016', '1997-05-05', 5000, 'Операційні системи', 5),
(14, 44, false, 'Відповіді на актуальні запитання щодо OS/2 Warp', 5, 4, 352, '60х84/16', '1996-03-20', 5000, 'Операційні системи', 5),
(15, 5176, false, 'Windows Ме. Супутник користувача', 12.79, 1, 306, '', '2000-10-10', 5000, 'Операційні системи', 5),
(16, 5462, false, 'Мова програмування С++. Лекції та вправи ', 29, 4, 656, '84х108/16', '2000-12-12', 5000, 'Програмування', 7),
(17, 4982, false, 'Мова програмування С. Лекції та вправи', 29, 4, 432, '84х108/16', '2000-12-07', 5000, 'Програмування', 7),
(18, 4687, false, 'Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів ', 17.6, 5, 240, '70х100/16', '2000-03-02', 5000, 'Програмування', 7),
(19, 235, false, 'Інформаційні системи і структури даних', NULL, 8, 288, '60х90/16', NULL, 400, 'Використання ПК в цілому', 4),
(20, 8746, true, 'Бази даних в інформаційних системах', NULL, 9, 418, '60х84/16', '2018-07-25', 100, 'Програмування', 8),
(21, 2154, true, 'Сервер на основі операційної системи FreeBSD 6.1', 0, 9, 216, '60х84/16', '2015-11-03', 500, 'Програмування ', 5),
(22, 2662, false, 'Організація баз даних та знань', 0, 10, 208, '60х90/16', '2001-10-10', 1000, 'Програмування', 8),
(23, 5641, true, 'Організація баз даних та знань', 0, 1, 384, '70х100/16', '2021-12-15', 5000, 'Програмування ', 8);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 1),
(10, 1),
(11, 2),
(12, 2),
(13, 1),
(14, 2),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 2),
(20, 2),
(21, 2),
(22, 1),
(23, 1);


CREATE VIEW UniversalView AS
SELECT 
    b.id AS book_id, 
    b.code AS book_code, 
    b.is_new, 
    b.name AS book_title, 
    b.price, 
    p.name AS publisher_name, 
    b.pages, 
    b.format, 
    b.published_at, 
    b.circulation, 
    b.topic, 
    c.name AS category_name, 
    a.name AS author_name
FROM 
    books b
INNER JOIN 
    publishers p ON b.publisher_id = p.id
INNER JOIN 
    book_authors ba ON b.id = ba.book_id
INNER JOIN 
    authors a ON ba.author_id = a.id
INNER JOIN 
    categories c ON b.category_id = c.id;


SELECT * FROM UniversalView;
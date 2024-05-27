-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT b.name AS book_title, b.price AS price, p.name AS publisher_name
FROM books b, publishers p
WHERE b.publisher_id = p.id;

-- 2. Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT b.name AS book_title, c.name AS category_name
FROM books b
INNER JOIN categories c ON b.category_id = c.id;

-- 3. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
SELECT b.name AS book_title, b.price AS price, p.name AS publisher_name, b.format AS format
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id;

-- 4. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
SELECT b.topic AS topic, c.name AS category, b.name AS book_title, p.name AS publisher_name
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id
INNER JOIN categories c ON b.category_id = c.id
WHERE b.topic = 'Програмування' AND c.name = 'SQL';

-- 5. Вивести книги видавництва 'BHV', видані після 2000 р
SELECT b.name AS book_title, b.published_at AS published_at
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id
WHERE p.name = 'Видавнича група BHV' AND b.published_at > '2000-01-01';

-- 6. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.
SELECT c.name AS category, SUM(b.pages) AS total_pages
FROM books b
INNER JOIN categories c ON b.category_id = c.id
GROUP BY c.name
ORDER BY total_pages DESC;

-- 7. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
SELECT AVG(b.price) AS average_price
FROM books b
INNER JOIN categories c ON b.category_id = c.id
WHERE b.topic = 'Використання ПК' AND c.name = 'Linux';

-- 8. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT b.*, p.name AS publisher_name, a.name AS author_name, c.name AS category_name
FROM books b, publishers p, book_authors ba, authors a, categories c
WHERE b.publisher_id = p.id AND b.id = ba.book_id AND ba.author_id = a.id AND b.category_id = c.id;

-- 9. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT b.*, p.name AS publisher_name, a.name AS author_name, c.name AS category_name
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id
INNER JOIN book_authors ba ON b.id = ba.book_id
INNER JOIN authors a ON ba.author_id = a.id
INNER JOIN categories c ON b.category_id = c.id;

-- 10. Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / right join.
SELECT b.*, p.name AS publisher_name, a.name AS author_name, c.name AS category_name
FROM books b
LEFT JOIN publishers p ON b.publisher_id = p.id
LEFT JOIN book_authors ba ON b.id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.id
LEFT JOIN categories c ON b.category_id = c.id;

-- 11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).
SELECT b1.name AS book1_title, b2.name AS book2_title, b1.pages AS pages
FROM books b1
INNER JOIN books b2 ON b1.pages = b2.pages AND b1.id <> b2.id;

-- 12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).
SELECT b1.name AS book1_title, b2.name AS book2_title, b3.name AS book3_title, b1.price AS price
FROM books b1
INNER JOIN books b2 ON b1.price = b2.price AND b1.id <> b2.id
INNER JOIN books b3 ON b1.price = b3.price AND b1.id <> b3.id AND b2.id <> b3.id;

-- 13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).
SELECT *
FROM books
WHERE category_id = (SELECT id FROM categories WHERE name = 'C&C++');

-- 14. Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (subquery).
SELECT *
FROM books
WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV') AND published_at > '2000-01-01';

-- 15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).
SELECT name
FROM publishers p
WHERE EXISTS (
    SELECT 1
    FROM books b
    WHERE b.publisher_id = p.id AND b.pages > 400
);

-- 16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).
SELECT name
FROM categories c
WHERE (
    SELECT COUNT(*)
    FROM books b
    WHERE b.category_id = c.id
) > 3;

-- 17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.
SELECT *
FROM books
WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
AND EXISTS (
    SELECT 1
    FROM books
    WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
);

-- 18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.
SELECT *
FROM books
WHERE NOT EXISTS (
    SELECT 1
    FROM books
    WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
);

-- 19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.
SELECT topic
FROM books
UNION
SELECT name
FROM categories
ORDER BY topic;

-- 20. Вивести відсортований в зворотному порядку загальний список перших слів, назв книг і категорій що не повторюються. Використовувати union.
SELECT DISTINCT LEFT(name, INSTR(name, ' ') - 1) AS first_word
FROM books
UNION
SELECT DISTINCT name
FROM categories
ORDER BY first_word DESC;
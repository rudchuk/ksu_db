-- 1. Вивести книги у яких не введена ціна або ціна дорівнює 0
SELECT * FROM books WHERE price IS NULL OR price = 0;

-- 2. Вивести книги у яких введена ціна, але не введений тираж
SELECT * FROM books WHERE price IS NOT NULL AND circulation IS NULL;

-- 3. Вивести книги, про дату видання яких нічого не відомо
SELECT * FROM books WHERE published_at IS NULL;

-- 4. Вивести книги, з дня видання яких пройшло не більше року
SELECT * FROM books WHERE published_at >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- 5. Вивести список книг-новинок, відсортованих за зростанням ціни
SELECT * FROM books WHERE is_new = 1 ORDER BY price ASC;

-- 6. Вивести список книг з числом сторінок від 300 до 400, відсортованих в зворотному алфавітному порядку назв
SELECT * FROM books WHERE pages BETWEEN 300 AND 400 ORDER BY name DESC;

-- 7. Вивести список книг з ціною від 20 до 40, відсортованих за спаданням дати
SELECT * FROM books WHERE price BETWEEN 20 AND 40 ORDER BY published_at DESC;

-- 8. Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій
SELECT * FROM books ORDER BY name ASC, price DESC;

-- 9. Вивести книги, у яких ціна однієї сторінки < 10 копійок
SELECT * FROM books WHERE price / pages < 0.1;

-- 10. Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами
SELECT CHAR_LENGTH(name) AS name_length, UPPER(SUBSTRING(name, 1, 20)) AS name_upper FROM books;

-- 11. Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...'
SELECT CONCAT(UPPER(SUBSTRING(name, 1, 10)), '...', UPPER(SUBSTRING(name, -10))) AS formatted_name FROM books;

-- 12. Вивести значення наступних колонок: назва, дата, день, місяць, рік
SELECT name, published_at, DAY(published_at) AS day, MONTH(published_at) AS month, YEAR(published_at) AS year FROM books;

-- 13. Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy'
SELECT name, published_at, DATE_FORMAT(published_at, '%d/%m/%Y') AS formatted_date FROM books;

-- 14. Вивести значення наступних колонок: код, ціна, ціна в грн., ціна в євро.
SELECT code, price, price * 40 AS price_uah, price * 0,93 AS price_euro FROM books;

-- 15. Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок округлена
SELECT code, price, FLOOR(price * 40) AS price_uah_whole, ROUND(price) AS price_rounded FROM books;

-- 16. Додати інформацію про нову книгу (всі колонки)
INSERT INTO books (code, is_new, name, price, publisher, pages, format, published_at, circulation, topic, category) 
VALUES (9999, 1, 'Нова книга', 100.00, 'Нове видавництво', 250, '60х90/16', '2024-05-21', 1000, 'Новий топік', 'Нова категорія');

-- 17. Додати інформацію про нову книгу (колонки обовязкові для введення)
INSERT INTO books (code, name, publisher, pages, circulation, topic, category) 
VALUES (10000, 'Ще одна нова книга', 'Інше нове видавництво', 200, 500, 'Інший новий топік', 'Інша нова категорія');

-- 18. Видалити книги, видані до 1990 року
DELETE FROM books WHERE published_at < '1990-01-01';

-- 19. Проставити поточну дату для тих книг, у яких дата видання відсутня
UPDATE books SET published_at = CURDATE() WHERE published_at IS NULL;

-- 20. Установити ознаку новинка для книг виданих після 2005 року
UPDATE books SET is_new = 1 WHERE published_at > '2005-01-01';

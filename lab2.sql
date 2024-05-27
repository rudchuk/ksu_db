-- 1. Вивести значення наступних колонок: номер, код, новинка, назва, ціна, сторінки
SELECT id, code, is_new, name, price, pages FROM books;

-- 2. Вивести значення всіх колонок
SELECT * FROM books;

-- 3. Вивести значення колонок в наступному порядку: код, назва, новинка, сторінки, ціна, номер
SELECT code, name, is_new, pages, price, id FROM books;

-- 4. Вивести значення всіх колонок 10 перших рядків
SELECT * FROM books LIMIT 10;

-- 5. Вивести значення всіх колонок 10% перших рядків
SELECT * FROM books LIMIT (SELECT ROUND(COUNT(*) * 0.1) FROM books);

-- 6. Вивести значення колонки код без повторення однакових кодів
SELECT DISTINCT code FROM books;

-- 7. Вивести всі книги новинки
SELECT * FROM books WHERE is_new = 1;

-- 8. Вивести всі книги новинки з ціною від 20 до 30
SELECT * FROM books WHERE is_new = 1 AND price BETWEEN 20 AND 30;

-- 9. Вивести всі книги новинки з ціною менше 20 і більше 30
SELECT * FROM books WHERE is_new = 1 AND (price < 20 OR price > 30);

--  10. Вивести всі книги з кількістю сторінок від 300 до 400 і з ціною більше 20 і менше 30
SELECT * FROM books WHERE pages BETWEEN 300 AND 400 AND price BETWEEN 20 AND 30;

-- 11. Вивести всі книги видані взимку 2000 року
SELECT * FROM books WHERE published_at BETWEEN '2000-01-01' AND '2001-02-28';

-- 12. Вивести книги зі значеннями кодів 5110, 5141, 4985, 4241
SELECT * FROM books WHERE code IN (5110, 5141, 4985, 4241);

-- 13. Вивести книги видані в 1999, 2001, 2003, 2005 р
SELECT * FROM books WHERE YEAR(published_at) IN (1999, 2001, 2003, 2005);

-- 14. Вивести книги назви яких починаються на літери А-К
SELECT * FROM books WHERE name REGEXP '^[А-Ка-к]';

-- 15. Вивести книги назви яких починаються на літери "АПП", видані в 2000 році з ціною до 20
SELECT * FROM books WHERE name LIKE 'АПП%' AND YEAR(published_at) = 2000 AND price <= 20;

-- 16. Вивести книги назви яких починаються на літери "АПП", закінчуються на "е", видані в першій половині 2000 року
SELECT * FROM books WHERE name LIKE 'АПП%е' AND published_at BETWEEN '2000-01-01' AND '2000-06-30';

-- 17. Вивести книги, в назвах яких є слово Microsoft, але немає слова Windows
SELECT * FROM books WHERE name LIKE '%Microsoft%' AND name NOT LIKE '%Windows%';

-- 18. Вивести книги, в назвах яких присутня як мінімум одна цифра.
SELECT * FROM books WHERE name REGEXP '[0-9]';

-- 19. Вивести книги, в назвах яких присутні не менше трьох цифр.
SELECT * FROM books WHERE name REGEXP '([0-9].*){3}';

-- 20. Вивести книги, в назвах яких присутній рівно п'ять цифр
SELECT * FROM books WHERE name REGEXP '^[^0-9]*([0-9][^0-9]*){5}$';
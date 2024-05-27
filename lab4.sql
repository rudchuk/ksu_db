-- 1. Вивести статистику: загальна кількість всіх книг, їх вартість, їх середню вартість, мінімальну і максимальну ціну
SELECT COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books;

-- 2. Вивести загальну кількість всіх книг без урахування книг з непроставленою ціною
SELECT COUNT(*) AS total_books 
FROM books 
WHERE price IS NOT NULL;

-- 3. Вивести статистику (див. 1) для книг новинка / не новинка
SELECT is_new, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
GROUP BY is_new;

-- 4. Вивести статистику (див. 1) для книг за кожним роком видання
SELECT YEAR(published_at) AS year, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
GROUP BY YEAR(published_at);

-- 5. Змінити п.4, виключивши з статистики книги з ціною від 10 до 20
SELECT YEAR(published_at) AS year, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
WHERE price < 10 OR price > 20 
GROUP BY YEAR(published_at);

-- 6. Змінити п.4. Відсортувати статистику по спадаючій кількості.
SELECT YEAR(published_at) AS year, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
GROUP BY YEAR(published_at) 
ORDER BY COUNT(*) DESC;

-- 7. Вивести загальну кількість кодів книг і кодів книг що не повторюються
SELECT COUNT(code) AS total_codes, 
       COUNT(DISTINCT code) AS unique_codes 
FROM books;

-- 8. Вивести статистику: загальна кількість і вартість книг по першій букві її назви
SELECT LEFT(name, 1) AS first_letter, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price 
FROM books 
GROUP BY LEFT(name, 1);

-- 9. Змінити п. 8, виключивши з статистики назви що починаються з англ. букви або з цифри.
SELECT LEFT(name, 1) AS first_letter, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price 
FROM books 
WHERE LEFT(name, 1) NOT REGEXP '^[A-Za-z0-9]' 
GROUP BY LEFT(name, 1);

-- 10. Змінити п. 9 так щоб до складу статистики потрапили дані з роками більшими за 2000.
SELECT LEFT(name, 1) AS first_letter, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price 
FROM books 
WHERE LEFT(name, 1) NOT REGEXP '^[A-Za-z0-9]' 
  AND YEAR(published_at) > 2000 
GROUP BY LEFT(name, 1);

-- 11. Змінити п. 10. Відсортувати статистику по спадаючій перших букв назви.
SELECT LEFT(name, 1) AS first_letter, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price 
FROM books 
WHERE LEFT(name, 1) NOT REGEXP '^[A-Za-z0-9]' 
  AND YEAR(published_at) > 2000 
GROUP BY LEFT(name, 1) 
ORDER BY first_letter DESC;

-- 12. Вивести статистику (див. 1) по кожному місяцю кожного року.
SELECT YEAR(published_at) AS year, 
       MONTH(published_at) AS month, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
GROUP BY YEAR(published_at), MONTH(published_at);

-- 13. Змінити п. 12 так щоб до складу статистики не увійшли дані з незаповненими датами.
SELECT YEAR(published_at) AS year, 
       MONTH(published_at) AS month, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
WHERE published_at IS NOT NULL 
GROUP BY YEAR(published_at), MONTH(published_at);

-- 14. Змінити п. 12. Фільтр по спадаючій року і зростанню місяця.
SELECT YEAR(published_at) AS year, 
       MONTH(published_at) AS month, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
WHERE published_at IS NOT NULL 
GROUP BY YEAR(published_at), MONTH(published_at) 
ORDER BY year DESC, month ASC;

-- 15. Вивести статистику для книг новинка / не новинка: загальна ціна, загальна ціна в грн. / Євро / руб.
SELECT is_new, 
       SUM(price) AS total_price_usd, 
       SUM(price * 27) AS total_price_uah, 
       SUM(price * 0.85) AS total_price_euro, 
       SUM(price * 75) AS total_price_rub 
FROM books 
GROUP BY is_new;

-- 16. Змінити п. 15 так щоб виводилася округлена до цілого числа (дол. / Грн. / Євро / руб.) Ціна.
SELECT is_new, 
       ROUND(SUM(price)) AS total_price_usd, 
       ROUND(SUM(price * 27)) AS total_price_uah, 
       ROUND(SUM(price * 0.85)) AS total_price_euro, 
       ROUND(SUM(price * 75)) AS total_price_rub 
FROM books 
GROUP BY is_new;

-- 17. Вивести статистику (див. 1) по видавництвах.
SELECT publisher, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
GROUP BY publisher;

-- 18. Вивести статистику (див. 1) за темами і видавництвами. Фільтр по видавництвам.
SELECT topic, 
       publisher, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
WHERE publisher = 'Видавнича група BHV' 
GROUP BY topic, publisher;

-- 19. Вивести статистику (див. 1) за категоріями, темами і видавництвами. Фільтр по видавництвам, темах, категоріям.
SELECT category, 
       topic, 
       publisher, 
       COUNT(*) AS total_books, 
       SUM(price) AS total_price, 
       AVG(price) AS average_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price 
FROM books 
WHERE publisher = 'Видавнича група BHV' 
  AND topic = 'Програмування' 
  AND category = 'SQL' 
GROUP BY category, topic, publisher;

-- 20. Вивести список видавництв, у яких округлена до цілого ціна однієї сторінки більше 10 копійок.
SELECT publisher 
FROM books 
GROUP BY publisher 
HAVING ROUND(SUM(price) / SUM(pages)) > 0.1;

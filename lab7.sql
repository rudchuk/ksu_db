-- 1. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetBooksInfo()
BEGIN
    SELECT b.name AS book_title, b.price AS price, p.name AS publisher_name, b.format AS format
    FROM books b
    INNER JOIN publishers p ON b.publisher_id = p.id;
END //
DELIMITER ;

CALL GetBooksInfo();

-- 2. Збережена процедура з вхідними параметрами
DELIMITER //
CREATE PROCEDURE GetBooksByTopicCategory(IN topic_name VARCHAR(255), IN category_name VARCHAR(255))
BEGIN
    SELECT b.topic AS topic, c.name AS category, b.name AS book_title, p.name AS publisher_name
    FROM books b
    INNER JOIN publishers p ON b.publisher_id = p.id
    INNER JOIN categories c ON b.category_id = c.id
    WHERE b.topic = topic_name AND c.name = category_name;
END //
DELIMITER ;

CALL GetBooksByTopicCategory('Програмування', 'SQL');

-- 3. Збережена процедура з вхідними параметрами за замовчуванням
DELIMITER //
CREATE PROCEDURE GetBooksByPublisherAfterYear(IN publisher_name VARCHAR(255), IN year DATE DEFAULT '2000-01-01')
BEGIN
    SELECT b.name AS book_title, b.published_at AS published_at
    FROM books b
    INNER JOIN publishers p ON b.publisher_id = p.id
    WHERE p.name = publisher_name AND b.published_at > year;
END //
DELIMITER ;

CALL GetBooksByPublisherAfterYear('Видавнича група BHV');

-- 4. Збережена процедура з вхідним параметром для сортування
DELIMITER //
CREATE PROCEDURE GetTotalPagesByCategory(IN sort_order VARCHAR(10))
BEGIN
    SET @sql = CONCAT('SELECT c.name AS category, SUM(b.pages) AS total_pages
                       FROM books b
                       INNER JOIN categories c ON b.category_id = c.id
                       GROUP BY c.name
                       ORDER BY total_pages ', sort_order);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL GetTotalPagesByCategory('DESC');

-- 5. Збережена процедура з вхідними параметрами
DELIMITER //
CREATE PROCEDURE GetAveragePriceByTopicCategory(IN topic_name VARCHAR(255), IN category_name VARCHAR(255))
BEGIN
    SELECT AVG(b.price) AS average_price
    FROM books b
    INNER JOIN categories c ON b.category_id = c.id
    WHERE b.topic = topic_name AND c.name = category_name;
END //
DELIMITER ;

CALL GetAveragePriceByTopicCategory('Використання ПК', 'Linux');

-- 6. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetUniversalView()
BEGIN
    SELECT * FROM UniversalView;
END //
DELIMITER ;

CALL GetUniversalView();

-- 7. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetBooksWithSamePages()
BEGIN
    SELECT b1.name AS book1_title, b2.name AS book2_title, b1.pages AS pages
    FROM books b1
    INNER JOIN books b2 ON b1.pages = b2.pages AND b1.id <> b2.id;
END //
DELIMITER ;

CALL GetBooksWithSamePages();

-- 8. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetBooksWithSamePrice()
BEGIN
    SELECT b1.name AS book1_title, b2.name AS book2_title, b3.name AS book3_title, b1.price AS price
    FROM books b1
    INNER JOIN books b2 ON b1.price = b2.price AND b1.id <> b2.id
    INNER JOIN books b3 ON b1.price = b3.price AND b1.id <> b3.id AND b2.id <> b3.id;
END //
DELIMITER ;

CALL GetBooksWithSamePrice();

-- 9. Збережена процедура з вхідним параметром
DELIMITER //
CREATE PROCEDURE GetBooksByCategory(IN category_name VARCHAR(255))
BEGIN
    SELECT *
    FROM books
    WHERE category_id = (SELECT id FROM categories WHERE name = category_name);
END //
DELIMITER ;

CALL GetBooksByCategory('C&C++');

-- 10. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetPublishersWithLargeBooks()
BEGIN
    SELECT name
    FROM publishers p
    WHERE EXISTS (
        SELECT 1
        FROM books b
        WHERE b.publisher_id = p.id AND b.pages > 400
    );
END //
DELIMITER ;

CALL GetPublishersWithLargeBooks();

-- 11. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetCategoriesWithMoreThanThreeBooks()
BEGIN
    SELECT name
    FROM categories c
    WHERE (
        SELECT COUNT(*)
        FROM books b
        WHERE b.category_id = c.id
    ) > 3;
END //
DELIMITER ;

CALL GetCategoriesWithMoreThanThreeBooks();

-- 12. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetBooksIfBHVExists()
BEGIN
    SELECT *
    FROM books
    WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
    AND EXISTS (
        SELECT 1
        FROM books
        WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
    );
END //
DELIMITER ;

CALL GetBooksIfBHVExists();

-- 13. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetBooksIfBHVNotExists()
BEGIN
    SELECT *
    FROM books
    WHERE NOT EXISTS (
        SELECT 1
        FROM books
        WHERE publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV')
    );
END //
DELIMITER ;

CALL GetBooksIfBHVNotExists();

-- 14. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetSortedTopicsAndCategories()
BEGIN
    SELECT topic
    FROM books
    UNION
    SELECT name
    FROM categories
    ORDER BY topic;
END //
DELIMITER ;

CALL GetSortedTopicsAndCategories();

-- 15. Збережена процедура без параметрів
DELIMITER //
CREATE PROCEDURE GetSortedUniqueFirstWordsAndCategories()
BEGIN
    SELECT DISTINCT LEFT(name, INSTR(name, ' ') - 1) AS first_word
    FROM books
    UNION
    SELECT DISTINCT name
    FROM categories
    ORDER BY first_word DESC;
END //
DELIMITER ;

CALL GetSortedUniqueFirstWordsAndCategories();

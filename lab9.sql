-- 1. Скалярна функція, що повертає загальну вартість книг виданих в певному році
DELIMITER //
CREATE FUNCTION TotalBookPriceByYear(year INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_price DECIMAL(10, 2);
    SELECT SUM(price) INTO total_price
    FROM books
    WHERE YEAR(published_at) = year;
    RETURN total_price;
END //
DELIMITER ;

-- Виклик функції
SELECT TotalBookPriceByYear(2000);

-- 2. Таблична (inline) функція, яка повертає список книг виданих в певному році
DELIMITER //
CREATE FUNCTION BooksPublishedInYear(year INT) RETURNS TABLE
RETURN
    SELECT *
    FROM books
    WHERE YEAR(published_at) = year;
END //
DELIMITER ;

-- Виклик функції
SELECT * FROM BooksPublishedInYear(2000);

-- 3. Функція типу multi-statement
DELIMITER //
CREATE FUNCTION NumberedPublisherList(publishers_list TEXT) RETURNS TABLE
RETURN
    WITH RECURSIVE split_publishers AS (
        SELECT
            SUBSTRING_INDEX(publishers_list, ';', 1) AS publisher_name,
            SUBSTRING(publishers_list, LOCATE(';', publishers_list) + 1) AS remaining_publishers,
            1 AS id
        UNION ALL
        SELECT
            SUBSTRING_INDEX(remaining_publishers, ';', 1) AS publisher_name,
            SUBSTRING(remaining_publishers, LOCATE(';', remaining_publishers) + 1) AS remaining_publishers,
            id + 1 AS id
        FROM split_publishers
        WHERE remaining_publishers <> ''
    )
    SELECT id, publisher_name FROM split_publishers;
END //
DELIMITER ;

-- Виклик функції
SELECT * FROM NumberedPublisherList('Видавнича група BHV;Вiльямс;МикроАрт');

-- 4. Робота з курсором для виводу списку книг виданих у визначеному році
DELIMITER //
CREATE PROCEDURE GetBooksByYearCursor(IN pub_year INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE book_id INT;
    DECLARE book_name VARCHAR(255);
    DECLARE book_cursor CURSOR FOR 
        SELECT id, name FROM books WHERE YEAR(published_at) = pub_year;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN book_cursor;

    read_loop: LOOP
        FETCH book_cursor INTO book_id, book_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Тут ви можете обробляти дані з курсору, наприклад, зберігати їх в тимчасову таблицю або виводити
        SELECT book_id, book_name;
    END LOOP;

    CLOSE book_cursor;
END //
DELIMITER ;

-- Виклик процедури
CALL GetBooksByYearCursor(2000);

-- 5. Робота з курсором: оголосити, відкрити, вибрати, закрити та звільнити курсор
DELIMITER //
CREATE PROCEDURE CursorExample()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE book_id INT;
    DECLARE book_name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT id, name FROM books WHERE YEAR(published_at) = 2000;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO book_id, book_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Тут ви можете обробляти дані з курсору
        SELECT book_id, book_name;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- Виклик процедури
CALL CursorExample();

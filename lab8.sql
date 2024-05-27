-- 1. Кількість тем може бути в діапазоні від 5 до 10.
DELIMITER //
CREATE TRIGGER check_topic_count
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    DECLARE topic_count INT;
    SELECT COUNT(DISTINCT topic) INTO topic_count FROM books;
    IF topic_count < 5 OR topic_count > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The number of topics must be between 5 and 10.';
    END IF;
END //
DELIMITER ;

-- 2. Новинкою може бути тільки книга видана в поточному році.
DELIMITER //
CREATE TRIGGER check_is_new
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF NEW.is_new = TRUE AND YEAR(NEW.published_at) <> YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A new book can only be a book published in the current year.';
    END IF;
END //
DELIMITER ;

-- 3. Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $.
DELIMITER //
CREATE TRIGGER check_book_price
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF NEW.pages <= 100 AND NEW.price > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A book with up to 100 pages cannot cost more than $10.';
    ELSEIF NEW.pages <= 200 AND NEW.price > 20 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A book with up to 200 pages cannot cost more than $20.';
    ELSEIF NEW.pages <= 300 AND NEW.price > 30 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A book with up to 300 pages cannot cost more than $30.';
    END IF;
END //
DELIMITER ;

-- 4. Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.
DELIMITER //
CREATE TRIGGER check_publisher_circulation
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF (NEW.publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV') AND NEW.circulation < 5000) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BHV does not publish books with a circulation of less than 5000.';
    ELSEIF (NEW.publisher_id = (SELECT id FROM publishers WHERE name = 'DiaSoft') AND NEW.circulation < 10000) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DiaSoft does not publish books with a circulation of less than 10000.';
    END IF;
END //
DELIMITER ;

-- 5. Книги з однаковим кодом повинні мати однакові дані.
DELIMITER //
CREATE TRIGGER check_book_code_consistency
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM books
        WHERE code = NEW.code
        AND (name <> NEW.name OR price <> NEW.price OR publisher_id <> NEW.publisher_id OR pages <> NEW.pages OR format <> NEW.format OR published_at <> NEW.published_at OR circulation <> NEW.circulation OR topic <> NEW.topic OR category_id <> NEW.category_id)
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Books with the same code must have identical data.';
    END IF;
END //
DELIMITER ;

-- 6. При спробі видалення книги видається інформація про кількість видалених рядків. Якщо користувач не "dbo", то видалення забороняється.
DELIMITER //
CREATE TRIGGER check_delete_permission
BEFORE DELETE ON books
FOR EACH ROW
BEGIN
    IF CURRENT_USER() <> 'dbo' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only the dbo user is allowed to delete books.';
    END IF;
END //

CREATE TRIGGER after_delete_books
AFTER DELETE ON books
FOR EACH ROW
BEGIN
    DECLARE deleted_count INT;
    SELECT ROW_COUNT() INTO deleted_count;
    SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = CONCAT('Deleted rows: ', deleted_count);
END //
DELIMITER ;

-- 7. Користувач "dbo" не має права змінювати ціну книги.
DELIMITER //
CREATE TRIGGER check_dbo_update_price
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    IF CURRENT_USER() = 'dbo' AND OLD.price <> NEW.price THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The dbo user is not allowed to update the price of books.';
    END IF;
END //
DELIMITER ;

-- 8. Видавництва ДМК і Еком підручники не видають.
DELIMITER //
CREATE TRIGGER check_publisher_textbooks
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF NEW.category_id = (SELECT id FROM categories WHERE name = 'Підручники') AND (NEW.publisher_id = (SELECT id FROM publishers WHERE name = 'ДМК') OR NEW.publisher_id = (SELECT id FROM publishers WHERE name = 'Эком')) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Publishers ДМК and Эком do not publish textbooks.';
    END IF;
END //
DELIMITER ;

-- 9. Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.
DELIMITER //
CREATE TRIGGER check_publisher_new_books
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    DECLARE new_books_count INT;
    SELECT COUNT(*)
    INTO new_books_count
    FROM books
    WHERE publisher_id = NEW.publisher_id
    AND is_new = TRUE
    AND YEAR(published_at) = YEAR(CURDATE())
    AND MONTH(published_at) = MONTH(CURDATE());

    IF new_books_count >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A publisher cannot release more than 10 new books in a single month of the current year.';
    END IF;
END //
DELIMITER ;

-- 10. Видавництво BHV не випускає книги формату 60х88 / 16.
DELIMITER //
CREATE TRIGGER check_bhv_format
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF NEW.publisher_id = (SELECT id FROM publishers WHERE name = 'Видавнича група BHV') AND NEW.format = '60х88/16' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BHV does not publish books in the format 60х88/16.';
    END IF;
END //
DELIMITER ;

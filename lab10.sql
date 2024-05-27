-- 1. Створити користувальницький тип даних для зберігання оцінки учня
CREATE TYPE GradeType AS TINYINT NULL;

-- 2. Створити об'єкт-замовчування (default) зі значенням 3
CREATE DEFAULT DefaultGrade AS 3;

-- 3. Зв'язати об'єкт-замовчування з призначеним для користувача типом даних для оцінки
EXEC sp_bindefault 'DefaultGrade', 'GradeType';

-- 4. Отримати інформацію про призначений для користувача тип даних
EXEC sp_help 'GradeType';

-- 5. Створити об'єкт-правило (rule): a >= 1 і a <= 5 і зв'язати його з призначеним для користувача типом даних для оцінки
CREATE RULE GradeRule AS @value >= 1 AND @value <= 5;
EXEC sp_bindrule 'GradeRule', 'GradeType';

-- 6. Створити таблицю "Успішність студента", використовуючи новий тип даних
CREATE TABLE StudentGrades (
    student_id INT PRIMARY KEY,
    math GradeType,
    science GradeType,
    literature GradeType,
    history GradeType
);

-- 7. Скасувати всі прив'язки і видалити з бази даних тип даних користувача, замовчування і правило
EXEC sp_unbindefault 'GradeType';
EXEC sp_unbindrule 'GradeType';
DROP DEFAULT DefaultGrade;
DROP RULE GradeRule;
DROP TYPE GradeType;
-- Опис предметної області – області автоматизації: Інформаційна система Вузу
-- a) Користувачі та їх вимоги до створюваної автоматизованої системи:
--      Студенти:
--          Вимоги: доступ до інформації про курси, розклад занять, оцінки, навчальні матеріали.
--          Дії: перегляд розкладу, реєстрація на курси, перегляд оцінок, завантаження навчальних матеріалів.
--      Викладачі:
--          Вимоги: управління курсами, розкладом, оцінками студентів, навчальними матеріалами.
--          Дії: створення/редагування курсів, управління розкладом, виставлення оцінок, завантаження навчальних матеріалів.
--      Адміністратори:
--          Вимоги: управління користувачами, курсами, розкладом, загальною інформацією про вуз.
--          Дії: створення/редагування/видалення користувачів, курсів, розкладів, надання доступів.
-- b) Документи, що циркулюють в предметній області:
--      Розклад занять:
--          Формується адміністрацією, доступний для студентів і викладачів.
--      Оцінки студентів:
--          Вносяться викладачами, доступні для студентів і адміністрації.
--      Навчальні матеріали:
--          Завантажуються викладачами, доступні для студентів.
--      Особисті дані студентів і викладачів:
--          Оновлюються відповідними користувачами, зберігаються в системі.
-- c) Правила за якими вони формуються:
--      Розклад занять:
--          Повинен бути сформований до початку навчального семестру.
--          Включає інформацію про курси, викладачів, аудиторії та час проведення занять.
--      Оцінки студентів:
--          Виставляються після завершення навчального модуля або семестру.
--          Повинні бути підтверджені викладачем.
--      Навчальні матеріали:
--          Мають бути актуальними і відповідати курсу.
--          Можуть бути завантажені тільки викладачами.
--      Особисті дані:
--          Повинні бути точними і актуальними.
--          Захищені від несанкціонованого доступу.
-- d) Опис обмежень на інформацію, що повинна зберігатись в БД:
--      Оцінки:
--          Повинні бути в діапазоні від 1 до 5.
--      Розклад:
--          Не повинно бути накладок в часі для одного викладача або аудиторії.
--      Особисті дані:
--          Обов’язкові поля: ім’я, прізвище, дата народження, контактна інформація.
--      Курси:
--          Кожен курс повинен мати унікальний ідентифікатор, назву, опис та викладача.

-- Словник БД
--      Студенти (students):
--          id (INT, PK)
--          first_name (VARCHAR)
--          last_name (VARCHAR)
--          birth_date (DATE)
--          contact_info (VARCHAR)
--          group_name (VARCHAR)
--      Викладачі (teachers):
--          id (INT, PK)
--          first_name (VARCHAR)
--          last_name (VARCHAR)
--          birth_date (DATE)
--          contact_info (VARCHAR)
--          department (VARCHAR)
--      Курси (courses):
--          id (INT, PK)
--          name (VARCHAR)
--          description (TEXT)
--          teacher_id (INT, FK)
--      Розклад (schedule):
--          id (INT, PK)
--          course_id (INT, FK)
--          teacher_id (INT, FK)
--          room (VARCHAR)
--          day_of_week (VARCHAR)
--          start_time (TIME)
--          end_time (TIME)
--      Оцінки (grades):
--          id (INT, PK)
--          student_id (INT, FK)
--          course_id (INT, FK)
--          grade (GradeType)
--      Навчальні матеріали (materials):
--          id (INT, PK)
--          course_id (INT, FK)
--          title (VARCHAR)
--          file_data (BLOB)
--      Зв'язок студентів і курсів (student_courses):
--          student_id (INT, FK)
--          course_id (INT, FK)
--          PRIMARY KEY (student_id, course_id)

-- Визначення сутностей предметної області, їх атрибути:
--      Студенти:
--          id, first_name, last_name, birth_date, contact_info, group_name.
--      Викладачі:
--          id, first_name, last_name, birth_date, contact_info, department.
--      Курси:
--          id, name, description, teacher_id.
--      Розклад:
--          id, course_id, teacher_id, room, day_of_week, start_time, end_time.
--      Оцінки:
--          id, student_id, course_id, grade.
--      Навчальні матеріали:
--          id, course_id, title, file_data.
--      Зв'язок студентів і курсів:
--          student_id, course_id.

-- Визначення зв'язків між сутностями предметної області. Інфологічна модель:
--      Студенти:
--          Один студент може бути зареєстрований на багато курсів (Багато-до-Багато зв'язок через таблицю "student_courses").
--      Викладачі:
--          Один викладач може вести багато курсів (Один-до-Багато).
--      Курси:
--          Один курс може мати багато записів у розкладі (Один-до-Багато).
--          Один курс може мати багато навчальних матеріалів (Один-до-Багато).
--      Розклад:
--          Один курс може мати багато записів у розкладі.
--          Один викладач може мати багато записів у розкладі.
--      Оцінки:
--          Один студент може мати багато оцінок.
--          Один курс може мати багато оцінок.
--      Навчальні матеріали:
--          Один курс може мати багато навчальних матеріалів.
--      Зв'язок студентів і курсів:
--          Один студент може бути зареєстрований на багато курсів.
--          Один курс може мати багато студентів.


-- Створення таблиць
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    contact_info VARCHAR(255),
    group_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    contact_info VARCHAR(255),
    department VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE IF NOT EXISTS schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    teacher_id INT,
    room VARCHAR(50),
    day_of_week VARCHAR(20),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE IF NOT EXISTS grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE IF NOT EXISTS materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    title VARCHAR(255),
    file_data BLOB,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE IF NOT EXISTS student_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Запити

-- Вивести інформацію про всіх студентів
SELECT * FROM students;

-- Вивести розклад для конкретного курсу
SELECT s.day_of_week, s.start_time, s.end_time, t.first_name, t.last_name, c.name, s.room
FROM schedule s
JOIN courses c ON s.course_id = c.id
JOIN teachers t ON s.teacher_id = t.id
WHERE c.id = 1;

-- Вивести оцінки студентів з конкретного курсу
SELECT st.first_name, st.last_name, g.grade
FROM grades g
JOIN students st ON g.student_id = st.id
WHERE g.course_id = 1;

-- Вивести список курсів, які викладає конкретний викладач
SELECT c.name, c.description
FROM courses c
JOIN teachers t ON c.teacher_id = t.id
WHERE t.id = 1;

-- Вивести навчальні матеріали для конкретного курсу
SELECT m.title
FROM materials m
JOIN courses c ON m.course_id = c.id
WHERE c.id = 1;

-- 1. СОЗДАНИЕ БАЗЫ ДАННЫХ
CREATE DATABASE IF NOT EXISTS task_management;

-- 2. СОЗДАНИЕ ТАБЛИЦ

-- Таблица tasks для хранения информации о задачах
CREATE TABLE IF NOT EXISTS tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    priority ENUM('Высокий', 'Средний', 'Низкий') NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('Выполнена', 'В процессе', 'Отложена') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица users для хранения информации о пользователях
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица task_assignments для учета назначений задач пользователям
CREATE TABLE IF NOT EXISTS task_assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    );



-- 3. УСТАНОВКА СВЯЗЕЙ МЕЖДУ ТАБЛИЦАМИ
ALTER TABLE task_assignments 
ADD FOREIGN KEY (task_id) REFERENCES tasks(id);

ALTER TABLE task_assignments 
ADD FOREIGN KEY (user_id) REFERENCES users(id);


--4. ДОБАВЛЕНИЕ ДАННЫХ
--данные пользователей
INSERT INTO users (name, email) VALUES 
('Иван Петров', 'ivan@example.com'),
('Мария Сидорова', 'maria@example.com'),
('Алексей Козлов', 'alexey@example.com');

--тестовые задачи
INSERT INTO tasks (title, priority, due_date, status) VALUES 
('Разработать дизайн сайта', 'Высокий', '2024-02-15', 'В процессе'),
('Написать документацию', 'Средний', '2024-02-20', 'Отложена'),
('Протестировать приложение', 'Низкий', '2024-02-10', 'Выполнена');

-- задачи пользователям
INSERT INTO task_assignments (task_id, user_id) VALUES 
(1, 1), -- Иван назначен на разработку дизайна
(2, 3), -- Алексей назначен на написание документации
(3, 1); -- Иван назначен на тестирование приложения


--5. ЗАПРОСЫ

-- Запрос 1: Получение списка всех задач с приоритетом и сроками выполнения
SELECT 
    id AS 'ID задачи',
    title AS 'Название задачи',
    priority AS 'Приоритет',
    due_date AS 'Срок выполнения',
    status AS 'Статус'
FROM tasks
ORDER BY due_date ASC;

-- Запрос 2: Получение всех задач определенного пользователя (ИВАН)
SELECT 
    t.title AS 'Название задачи',
    t.priority AS 'Приоритет',
    t.due_date AS 'Срок выполнения',
    t.status AS 'Статус'
FROM tasks t
JOIN task_assignments ta ON t.id = ta.task_id
JOIN users u ON ta.user_id = u.id
WHERE u.name = 'Иван Петров'
ORDER BY t.priority DESC, t.due_date ASC;

-- Запрос 3: Поиск задач с высоким приоритетом, срок выполнения которых истекает в ближайшие 7 дней
SELECT 
    title AS 'Название задачи',
    due_date AS 'Срок выполнения',
    status AS 'Статус'
FROM tasks
WHERE priority = 'Высокий'
  AND status != 'Выполнена'  -- Исключаем уже выполненные задачи
  AND due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY due_date ASC;

-- Запрос 4: Получение количества задач в каждом статусе
SELECT 
    status AS 'Статус',
    COUNT(*) AS 'Количество задач'
FROM tasks
GROUP BY status
ORDER BY COUNT(*) DESC;



6. ДОП  




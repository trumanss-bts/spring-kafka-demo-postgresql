CREATE TABLE IF NOT EXISTS users (
                                     id BIGSERIAL PRIMARY KEY,
                                     name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Создание таблицы
CREATE TABLE IF NOT EXISTS tasks (
                                     id BIGSERIAL PRIMARY KEY,
                                     name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    executor_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_task_executor FOREIGN KEY (executor_id) REFERENCES users(id) ON DELETE SET NULL
    );

-- индексы
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_executor_id ON tasks(executor_id);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- пользаки
INSERT INTO users (name, email) VALUES
                                    ('Иван Иванов', 'ivan@example.com'),
                                    ('Петр Петров', 'petr@example.com'),
                                    ('Мария Сидорова', 'maria@example.com')
    ON CONFLICT (email) DO NOTHING;

-- таски
INSERT INTO tasks (name, description, status, executor_id) VALUES
                                                               ('Реализовать API', 'Разработать REST API для управления задачами', 'PENDING', 1),
                                                               ('Настроить Kafka', 'Настроить продюсеров и консьюмеров на KRaft', 'PENDING', 2),
                                                               ('Написать тесты', 'Покрыть код тестами', 'PENDING', NULL),
                                                               ('Документация', 'Написать документацию к API', 'COMPLETED', 3)
    ON CONFLICT DO NOTHING;
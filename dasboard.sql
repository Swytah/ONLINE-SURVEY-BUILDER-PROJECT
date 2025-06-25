-- Create the database
CREATE DATABASE IF NOT EXISTS survey_builder;
USE survey_builder;
-- USERS TABLE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- SURVEYS TABLE
CREATE TABLE surveys (
    survey_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE
);
-- QUESTIONS TABLE
CREATE TABLE questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT,
    question_text TEXT NOT NULL,
    question_type ENUM('single_choice', 'multiple_choice', 'text', 'rating') NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);
-- ANSWER OPTIONS TABLE (for choice questions)
CREATE TABLE answer_options (
    option_id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);
-- RESPONSES TABLE (a user answering a survey)
CREATE TABLE responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    survey_id INT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);
-- ANSWERS TABLE (each answer per question)
CREATE TABLE answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    response_id INT,
    question_id INT,
    option_id INT,         -- Used for choices
    text_answer TEXT,      -- Used for open-ended text
    rating_value INT,      -- Used for rating questions
    FOREIGN KEY (response_id) REFERENCES responses(response_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id),
    FOREIGN KEY (option_id) REFERENCES answer_options(option_id)
);
-- Insert one user
INSERT INTO users (username, email)
VALUES ('ABC', 'abc@example.com');

-- Create one survey
INSERT INTO surveys (title, description, start_date, end_date)
VALUES ('Customer Feedback Survey', 'Tell us how we’re doing!', '2025-06-01', '2025-06-30');

-- Add 4 questions to the survey
INSERT INTO questions (survey_id, question_text, question_type)
VALUES 
(1, 'How satisfied are you with our service?', 'rating'),
(1, 'Which product do you like the most?', 'single_choice'),
(1, 'Which of these services have you used?', 'multiple_choice'),
(1, 'Any suggestions to improve?', 'text');

-- Add answer options (for questions 2 and 3)
INSERT INTO answer_options (question_id, option_text)
VALUES
(2, 'Product A'),
(2, 'Product B'),
(2, 'Product C'),
(3, 'Delivery'),
(3, 'Customer Support'),
(3, 'Returns');

-- Add one response (Sweta answering survey)
INSERT INTO responses (user_id, survey_id)
VALUES (1, 1);

-- Add answers (to each question)
-- Question 1: Rating (4 stars)
INSERT INTO answers (response_id, question_id, rating_value)
VALUES (1, 1, 4);

-- Question 2: Single choice (Product B -> option_id 2)
INSERT INTO answers (response_id, question_id, option_id)
VALUES (1, 2, 2);

-- Question 3: Multiple choice (Delivery and Returns -> option_id 4 & 6)
INSERT INTO answers (response_id, question_id, option_id)
VALUES (1, 3, 4),
       (1, 3, 6);
-- Question 4: Text answer
INSERT INTO answers (response_id, question_id, text_answer)
VALUES (1, 4, 'Keep up the good work!');

-- Dashboard


-- Total responses per survey
SELECT s.title, COUNT(r.response_id) AS total_responses
FROM surveys s
JOIN responses r ON s.survey_id = r.survey_id
GROUP BY s.survey_id;
-- Average rating per question
SELECT q.question_text, AVG(a.rating_value) AS average_rating
FROM questions q
JOIN answers a ON q.question_id = a.question_id
WHERE q.question_type = 'rating'
GROUP BY q.question_id;
-- Most selected options for multiple/single choice
SELECT q.question_text, ao.option_text, COUNT(*) AS selection_count
FROM answers a
JOIN answer_options ao ON a.option_id = ao.option_id
JOIN questions q ON ao.question_id = q.question_id
WHERE q.question_type IN ('single_choice', 'multiple_choice')
GROUP BY ao.option_id;

-- ONLINE SURVEY BUILDER PROJECT
-- Author: ABC
-- This SQL file sets up a complete database for building dynamic surveys.
-- Features include:
-- - Multiple question types (single, multi-choice, text, rating)
-- - Answer storage
-- - User participation
-- - Sample data
-- - Dashboard queries for analysis
-- `users`: Links to `responses` (who answered).

-- `surveys`: Links to `questions` (what questions are in it) and `responses` (which survey was taken).

-- `questions`: Links to `surveys` (its survey), `answer_options` (if it has choices), and `answers` (its actual responses).

-- `answer_options`: Links to `questions` (its question) and `answers` (if chosen).

-- `responses`: Links `users` to `surveys`, and collects all `answers` for one submission.

-- `answers`: Links to `responses` (its submission), `questions` (its question), and `answer_options` (if a choice was made).
/*
## Quick Visual:

+-------+       +--------+       +-----------+       +----------------+
| users |-----< | surveys|<----- | questions |-----< | answer_options |
+-------+       +--------+       +-----------+       +----------------+
    |               ^                  |                     ^
    |               |                  |                     |
    V               |                  V                     |
+-----------+       |              +--------+                |
| responses |-------+------------->| answers|----------------+
+-----------+                      +--------+
*/
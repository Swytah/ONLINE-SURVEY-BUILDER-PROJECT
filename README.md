# ONLINE-SURVEY-BUILDER-PROJECT
ONLINE SURVEY BUILDER PROJECT
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

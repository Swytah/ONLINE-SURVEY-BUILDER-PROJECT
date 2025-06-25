# Survey Builder Database Schema Visual

Here's a quick visual representation of how the tables in our survey database are connected. This diagram helps to understand the relationships between different data entities like users, surveys, questions, and answers.


+-------+       +--------+       +-----------+       +----------------+
| users |-----< | surveys|<----- | questions |-----< | answer_options |
+-------+       +--------+       +-----------+       +----------------+
|               ^                  |                     ^
|               |                  |                     |
V               |                  V                     |
+-----------+       |              +--------+                |
| responses |-------+------------->| answers|----------------+
+-----------+                      +--------+


*Arrows indicate relationships, generally pointing from a table with a foreign key to the table with the primary key it references.*

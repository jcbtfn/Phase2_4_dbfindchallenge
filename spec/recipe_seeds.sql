-- EXAMPLE
-- file: recipe_seeds.sql

-- Replace the table name, columm names and types.

-- CREATE TABLE recipes (
--    id SERIAL PRIMARY KEY,
--    name text,
--    avg_cooking_time int, 
--    rating int
--);

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Spanish Omelette', 45, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Thai Curry', 30, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Pasta alla Norma', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Egg Fried Rice', 20, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Breaded Mushrooms', 30, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Guacamole', 15, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Lentil Dhal', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Greek Salad', 20, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Fish and Chips', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Beans & Bacon', 45, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Gozlehme', 60, 4);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Double Cheeseburger', 10, 3);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Chicken Wings', 15, 2);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Peas', 20, 1);
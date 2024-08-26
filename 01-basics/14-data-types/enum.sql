/**
 * https://stackoverflow.com/questions/10923213/postgres-enum-data-type-or-check-constraint
 * Option 1 - ENUM type
 * Option 2 - CHECK constraint
 * Option 3 - Lookup Table
 */

CREATE TYPE MEAL_TIME AS ENUM ('Breakfast', 'Lunch', 'Dinner');

/**
 * Advantages are that the type can be defined once and then reused in as many tables as needed.
 * ENUM type is actually a data type separate from the built-in NUMERIC and TEXT data types, the
 * regular numeric and string operators and functions don't work on it.
 */

CREATE TABLE menu (
  menu_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title VARCHAR(70) NOT NULL,
  meal_time MEAL_TIME NOT NULL
);

INSERT INTO
  menu (title, meal_time)
VALUES
  ('Chicken Tapa w/ Scrambled Egg and Roasted Tomato', 'Breakfast'),
  ('Grilled Porkchop w/ Chop Suey', 'Lunch'),
  ('Chopped Salad w/ Chili Corn Carne', 'Dinner'),
  ('Seafood and Chorizo Egg Cake', 'Breakfast'),
  ('Kung Pao Chicken w/ Sauteed String Beans and Sayote', 'Lunch'),
  ('Pork BBQ Skewers w/ Grilled Tomato and Eggplant', 'Dinner');

SELECT
  *
FROM
  menu;

SELECT
  *
FROM
  menu
WHERE
  meal_time = 'Breakfast';

-- Invalid input value for enum meal_time: "Bre%"
SELECT
  *
FROM
  menu
WHERE
  meal_time = 'Bre%';

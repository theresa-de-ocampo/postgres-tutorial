-- Use ALL instead of (JOINS, ORDER BY, LIMIT) whenever you have a
-- "Get the top/bottom record in a specific group determined by the other table."
-- This is useful if you only need the data from the first table.

/**
 * TABLE: students
 * student_id
 * student_name
 * 
 * TABLE: exam_scores
 * student_id
 * exam_score
 * class_id
 */

-- Get the student(s) who scored higher than all scores in class 101.
SELECT student_name
FROM students
WHERE exam_score >= ALL (
  SELECT exam_score
  FROM exam_scores
  WHERE class_id = 101
);

-- Another Option
SELECT student_name
FROM students
WHERE exam_score >= (
  SELECT MAX(exam_score) FROM exam_scores WHERE class_id = 1
);

SELECT
  student_id,
  student_name,
  exam_score
FROM
  students
INNER JOIN
  exam_scores ON (student_id)
WHERE
  exam_score = (SELECT MAX(exam_score) FROM exam_scores WHERE class_id = 101);

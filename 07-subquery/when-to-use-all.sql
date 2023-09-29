-- Use ALL instead of (JOINS, ORDER BY, LIMIT) whenever you have a
-- "Get the top/bottom record in a specific group determined by the other table."

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

-- Get the student who scored higher than all scores in class 101.

SELECT student_name
FROM students
WHERE exam_score >= ALL (
  SELECT exam_score
  FROM exam_scores
  WHERE class_id = 101
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
  class_id = 101 AND
  exam_score = (SELECT MAX(exam_score) FROM exam_scores WHERE class_id = 101);

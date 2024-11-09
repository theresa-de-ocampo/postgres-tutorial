/**
 * The NULLIF function returns a null value if argument_1 equals to argument_2.
 * Otherwise, it returns argument_1.
 */
SELECT NULLIF(1, 1);
SELECT NULLIF(1, 2);
SELECT NULLIF('Chocolate', 'Custard');

-- *** Example 1: Text Display
CREATE TABLE post(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  excerpt VARCHAR(150),
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at TIMESTAMP
);

INSERT INTO
  post (title, excerpt, body)
VALUES
  (
    'A four-day workweek pilot was so successful most firms say they won’t go back',
    'Remote work has granted workers more power and autonomy than they may have previously had.',
    'The four-day workweek is proving to be the gift that keeps on giving. Companies that have tried it are reporting happier workers, lower turnover and greater efficiency. Now, there is evidence that those effects are long lasting. The latest data come from a trial in the U.K. In 2022, 61 companies moved their employees to a four-day workweek with no reduction in pay. They began it as a six-month experiment. But today, 54 of the companies still have the policy. Just over half have declared it permanent, according to researchers with the think tank Autonomy, who organized the trial along with the groups 4-Day Week Campaign and 4 Day Week Global.'
  ),
  (
    'The Future of Influencer Marketing Is Offline and Hyper Niche',
    '',
    'In an uncertain social media environment, some forward-looking brands are embracing offline (that is, in-person) influencer events. These “physical activations” put influencers directly in touch with communities that might not be addressable on traditional social media.'
  ),
  (
    'How Successful People Stay Calm - Dr. Travis Bradberry',
    NULL,
    'Besides increasing your risk of heart disease, depression, and obesity, stress decreases your cognitive performance. Fortunately, though, unless a lion is chasing you, the bulk of your stress is subjective and under your control. Top performers have well-honed coping strategies that they employ under stressful circumstances. This lowers their stress levels regardless of what’s happening in their environment, ensuring that the stress they experience is intermittent and not prolonged.'
  );

SELECT * FROM post;

SELECT
  id,
  title,
  COALESCE(
    NULLIF(excerpt, ''),
    LEFT(body, 40)
  )
FROM
  post;

-- *** Example 2: Prevent Division by Zero
CREATE TABLE "member" (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(75) NOT NULL,
  last_name VARCHAR(75) NOT NULL,
  gender SMALLINT NOT NULL -- 1: Male, 2: Female
);

INSERT INTO
  "member" (first_name, last_name, gender)
VALUES
  ('Grant', 'MacLaren', 1),
  ('Philip', 'Pearson', 1),
  ('Marcy', 'Warton', 2);

SELECT
  *
FROM
  "member";

-- Calculate the ratio between male and female members.
SELECT
  (
    SUM(
      CASE
        WHEN gender = 1 THEN 1
        ELSE 0
      END
    ) /
    SUM(
      CASE
        WHEN gender = 2 THEN 1
        ELSE 0
      END
    )
  ) * 100 AS "Male to Female Ratio"
FROM
  "member";

UPDATE
  "member"
SET
  gender = 3
WHERE
  id = 3;

/**
 * The total number of male members divided by NULL will return NULL.
 * This is a perfectly semantic solution to many division by zero problems.
 * Sometimes, you don't want the division to be some other value,
 * you want it not to be computed at all.
 */
SELECT
  (
    SUM(
      CASE
        WHEN gender = 1 THEN 1
        ELSE 0
      END
    ) /
    NULLIF(
      SUM(
        CASE
          WHEN gender = 2 THEN 1
          ELSE 0
        END
      ),
      0
    )
  ) * 100 AS "Male to Female Ratio"
FROM
  "member";


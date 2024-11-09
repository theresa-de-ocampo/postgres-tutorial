/**
 * If you want to display the excerpt from a blog post and the excerpt is not provided,
 * you can use the first 150 characters of the content of the post.
 * 
 * LEFT() function is used to get the first n characters in a string.
 */
SELECT
  COALESCE(
    excerpt,
    LEFT("content", 150)
  )
FROM
  posts;
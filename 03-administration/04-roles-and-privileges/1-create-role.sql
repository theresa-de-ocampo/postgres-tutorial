/*
 * PostgreSQL uses the concept of `roles` to represent `user` accounts.
 * It doesn't use the concept of users like other database systems.
 * 
 * Typically, roles that can log in to the PostgreSQL server are called login roles.
 * They are equivalent to user accounts in other database systems.
 * When roles can contain other roles, they are referred to as group roles. 
 * */

CREATE ROLE bob;

SELECT rolname FROM pg_roles;
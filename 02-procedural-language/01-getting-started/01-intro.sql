/**
 * Advantages of Using PL/pgSQL
 * PostgreSQL can only execute SQL statements individually.
 * If you have multiple statements, you'll have to execute them one by one.
 * This process incurs the interprocess communication and network overheads.
 * PL/pgSQL wraps multiple statements in an object and stores it on the PostgreSQL database server.
 * PL/pgSQL allow you to:
 *    - Reduce the number of round trips between the application and the PostgreSQL database server.
 *    - Avoid transferring the intermediate results between the application and the server.
 */
CREATE TABLE account (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_on TIMESTAMP NOT NULL,
  last_login TIMESTAMP NOT NULL
);

CREATE TABLE role (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE account_role (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  grant_date TIMESTAMP,

  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id)
    REFERENCES account (user_id),
  FOREIGN KEY (role_id)
    REFERENCES role (role_id)
);
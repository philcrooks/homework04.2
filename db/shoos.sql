DROP TABLE orders;
DROP TABLE items;

CREATE TABLE orders (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address VARCHAR(255),
  quantity INT2,
  size INT2
);

CREATE TABLE items (
  id SERIAL4 PRIMARY KEY,
  size INT2,
  available INT2
);
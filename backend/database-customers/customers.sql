CREATE DATABASE customers;

\c customers

CREATE TABLE customers(
    id serial PRIMARY KEY UNIQUE,
    first_name varchar(255),
    last_name varchar(255),
    age int,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);



CREATE OR REPLACE FUNCTION modify_customer_function()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_update_time
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE modify_customer_function();

CREATE OR REPLACE FUNCTION created_at_function()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_create_time
BEFORE INSERT ON customers
FOR EACH ROW
EXECUTE PROCEDURE created_at_function();
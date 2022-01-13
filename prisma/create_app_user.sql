-- reference: https://www.bazos.dev/blog/create-an-admin-user-in-postgresql

-- create the artisanwriting app user 
CREATE ROLE artisanwriting_app LOGIN PASSWORD 'password' CREATEDB;

-- restrict new user access to the database
REVOKE ALL ON DATABASE artisanwriting FROM public;
REVOKE ALL ON SCHEMA public FROM public;

-- create the artisanwriting admin user role.
CREATE ROLE artisanwriting_admin NOINHERIT;
GRANT CONNECT ON DATABASE artisanwriting TO artisanwriting_admin;
GRANT USAGE, CREATE ON SCHEMA public TO artisanwriting_admin;
ALTER DEFAULT PRIVILEGES GRANT ALL ON TABLES TO artisanwriting_admin;
ALTER DEFAULT PRIVILEGES GRANT ALL ON SEQUENCES TO artisanwriting_admin;
GRANT ALL ON ALL TABLES IN SCHEMA public TO artisanwriting_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO artisanwriting_admin;

-- grant admin rights to app
GRANT artisanwriting_admin TO artisanwriting_app;

-- create a new admin user
CREATE ROLE admin_user LOGIN PASSWORD 'changeme' INHERIT;
GRANT artisanwriting_admin TO admin_user;

-- remove a new admin user
DROP OWNED BY admin_user CASCADE;
DROP role admin_user;

-- remove admin user role
DROP OWNED BY admin_user CASCADE;
DROP role admin_user;

-- So I can remember how to set up the user roles for the artisanwriting database

create role prisma_client inherit createdb;
grant all privileges on schema public to prisma_client;

create role artisanwriting_ro noinherit;
revoke all on schema public from artisanwriting_ro;
grant select on all tables in schema public to artisanwriting_ro;

create role artisanwriting_app login password 'changeme' inherit;
grant prisma_client to artisanwriting_app;

create role jgreaves login password 'changeme' inherit;
grant artisanwriting_ro to jgreaves;

revoke connect on database artisanwriting from public;
grant connect on database artisanwriting to artisanwriting_app, jgreaves;

-- clean up
drop owned by prisma_client;
drop owned by artisanwriting_app;
drop role prisma_client;
drop role artisanwriting_app;

drop owned by artisanwriting_ro;
drop owned by jgreaves;
drop role artisanwriting_ro;
drop role jgreaves;
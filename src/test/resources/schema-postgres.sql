-- sample db and schema creation as optional reminder
-- in case a trash schema is not handy
--drop database if exists dbchain;
--drop user if exists dbchaintester;
--create database dbchaintest;
--create user dbchaintester with password 'postmanmushroomsquirrel';
--grant all privileges on database dbchaintest to dbchaintester;
--\connect dbchaintest
--create extension if not exists postgis;
drop table if exists dbchaintestdata;
drop table if exists dbchaintestexpected;
create table dbchaintestdata (
    id              integer primary key
   ,hoverboard      varchar(1)
   ,pavegold        integer
   ,junkcol         text
   ,shape           geometry(linestring, 2263));
create index dbchaintestdatashape on dbchaintestdata using GIST(shape);
--create table dbchaintestexpected (
--    id              integer primary key
--   ,hoverboard      varchar(1)
--   ,pavegold        integer
--   ,shape           geometry(linestring, 2263));


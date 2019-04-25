select 'creating phony placeholder output tables';
create table dbchainsimplified as select * from dbchaininput;
create table dbchainoutput as select * from dbchaininput;
